import serial
import mysql.connector
import time
from datetime import datetime
from twilio.rest import Client

# Twilio credentials
ACCOUNT_SID = 'ACded179e1c54d9da1a11d73ef58d8da1b'
AUTH_TOKEN = 'acd27d30faa5b5228c351f0d50e1ea1f'
TWILIO_PHONE_NUMBER = '+16467981365'

# Set up Twilio client
client = Client(ACCOUNT_SID, AUTH_TOKEN)

SERIAL_PORT = 'COM6'
BAUD_RATE = 9600
# # Unique keyword that Arduino sends on startup
# TARGET_KEYWORD = "timein"
# BAUD_RATE = 9600

# # Function to automatically detect the Arduino serial port
# def find_arduino_port():
#     ports = serial.tools.list_ports.comports()
#     for port in ports:
#         try:
#             # Attempt to open a temporary connection to each available port
#             ser = serial.Serial(port.device, BAUD_RATE, timeout=2)
#             time.sleep(2)  # Wait for the Arduino to initialize
            
#             # Check if Arduino sends the keyword "register" on startup
#             ser.write(b'\n')  # Send a new line to trigger a response
#             line = ser.readline().decode('utf-8').strip()
            
#             if TARGET_KEYWORD in line:
#                 print(f"Found Arduino on {port.device}")
#                 ser.close()
#                 return port.device  # Return the matching port
            
#             ser.close()
#         except (serial.SerialException, UnicodeDecodeError) as e:
#             # Skip ports that can't be accessed or don't provide expected data
#             print(f"Error reading {port.device}: {e}")
#     raise Exception("Arduino not found. Please check the connection.")

# # Automatically detect the Arduino port
# SERIAL_PORT = find_arduino_port()


# Database connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="gatesystem"
)
cursor = db.cursor()

# Open the serial port
ser = serial.Serial(SERIAL_PORT, BAUD_RATE)
print("Listening for RFID data for IN...")

# Function to get last log entry for a given ID
def get_last_log_id(cid):
    cursor.execute(
        "SELECT category, datetime FROM dailylogs WHERE stid = %s OR sid = %s ORDER BY datetime DESC LIMIT 1",
        (cid, cid)
    )
    return cursor.fetchone()

# Function to send SMS notification to the guardian
def send_sms_notification(guardiannumber, student_name):
    message = client.messages.create(
        body=f"Your child {student_name} has arrived at ST. CECILIA'S COLLEGE-CEBU, INC.",
        from_=TWILIO_PHONE_NUMBER,
        to=guardiannumber
    )
    print(f"SMS sent to {guardiannumber}: {message.sid}")

try:
    while True:
        if ser.in_waiting > 0:
            line = ser.readline().decode('utf-8').strip()
            print(f"Received: {line}")

            if line.startswith("Card UID: "):
                uid = line.split("Card UID: ")[1]
                
                # Check if UID exists in the database
                cursor.execute("SELECT cid FROM rfid WHERE uid = %s", (uid,))
                cid_result = cursor.fetchone()

                if cid_result:
                    cid = cid_result[0]

                    # Check in registaff table
                    cursor.execute("SELECT stid FROM registaff WHERE cid = %s", (cid,))
                    staff_result = cursor.fetchone()

                    # Check in registudent table
                    cursor.execute("SELECT sid, did, guardiannumber FROM registudent WHERE cid = %s", (cid,))
                    student_result = cursor.fetchone()

                    # Determine the category and log entry
                    if staff_result:
                        stid = staff_result[0]
                        last_log = get_last_log_id(stid)

                        # Logic for logging IN
                        if last_log:
                            last_category, last_datetime = last_log
                            last_date = last_datetime.date()
                            current_date = datetime.now().date()

                            if last_category == 'IN':
                                if current_date > last_date:
                                    cursor.execute(
                                        "INSERT INTO dailylogs (stid, category) VALUES (%s, 'IN')",
                                        (stid,)
                                    )
                                    print(f"Staff ID {stid} logged IN.")
                                else:
                                    print("Cannot log IN again without logging OUT first.")
                                    ser.write(b'ERROR_ALREADY_IN\n')
                            else:
                                cursor.execute(
                                    "INSERT INTO dailylogs (stid, category) VALUES (%s, 'IN')",
                                    (stid,)
                                )
                                print(f"Staff ID {stid} logged IN.")
                                ser.write(b'SUCCESS_IN\n')

                        else:
                            # If no previous log exists, log 'IN'
                            cursor.execute(
                                "INSERT INTO dailylogs (stid, category) VALUES (%s, 'IN')",
                                (stid,)
                            )
                            print(f"Staff ID {stid} logged IN.")
                            ser.write(b'SUCCESS_IN\n')

                    elif student_result:
                        sid, did, guardiannumber = student_result
                        last_log = get_last_log_id(sid)

                        # Retrieve student's name and department from the information table using `did`
                        cursor.execute("SELECT name, department FROM information WHERE did = %s", (did,))
                        student_info = cursor.fetchone()
                        student_name = student_info[0] if student_info else "Student"
                        department = student_info[1] if student_info else ""

                        # Logic for logging IN and SMS conditionally
                        send_sms = False  # Flag to determine if SMS should be sent

                        if last_log:
                            last_category, last_datetime = last_log
                            last_date = last_datetime.date()
                            current_date = datetime.now().date()

                            if last_category == 'IN':
                                if current_date > last_date:
                                    # Log the student IN
                                    cursor.execute(
                                        "INSERT INTO dailylogs (sid, category) VALUES (%s, 'IN')",
                                        (sid,)
                                    )
                                    print(f"Student ID {sid} ({student_name}) logged IN.")
                                    
                                    db.commit()
                                    ser.write(b'SUCCESS_IN\n')

                                    # Check department condition for SMS
                                    if department[:2].lower() in ['bs', 'be']:
                                        send_sms = True  # Only for first IN of the day
                                    else:
                                        send_sms = True  # Send SMS every IN
                                    
                                    # Send SMS if the condition is met
                                    if send_sms:
                                        send_sms_notification(guardiannumber, student_name)
                                        

                                else:
                                    print("Cannot log IN again without logging OUT first.")
                                    ser.write(b'ERROR_ALREADY_IN\n')
                            else:
                                # Log the student IN
                                cursor.execute(
                                    "INSERT INTO dailylogs (sid, category) VALUES (%s, 'IN')",
                                    (sid,)
                                )
                                print(f"Student ID {sid} ({student_name}) logged IN.")
                                db.commit()
                                ser.write(b'SUCCESS_IN\n')

                                # Check department condition for SMS
                                if department[:2].lower() in ['bs', 'be']:
                                        send_sms = True  # Only for first IN of the day
                                else:
                                        send_sms = True  # Send SMS every IN
                                    
                                # Send SMS if the condition is met
                                if send_sms:
                                    send_sms_notification(guardiannumber, student_name)

                        else:
                            # If no previous log exists, log 'IN'
                            cursor.execute(
                                "INSERT INTO dailylogs (sid, category) VALUES (%s, 'IN')",
                                (sid,)
                            )
                            print(f"Student ID {sid} ({student_name}) logged IN.")
                            db.commit()
                            ser.write(b'SUCCESS_IN\n')

                            # Check department condition for SMS
                            if department[:2].lower() in ['bs', 'be']:
                                send_sms = True  # Only first IN of the day for these departments
                            else:
                                send_sms = True  # Send SMS every IN
                            
                            # Send SMS if the condition is met
                            if send_sms:
                                send_sms_notification(guardiannumber, student_name)

                    else:
                        print("No matching record found in registaff or registudent.")
                        ser.write(b'ERROR_NO_RECORD\n')

                    db.commit()  # Commit the transaction

                else:
                    print("No matching UID found in the RFID table.")
                    ser.write(b'ERROR_NO_MATCH\n')

except KeyboardInterrupt:
    print("Exiting...")
finally:
    ser.close()
    cursor.close()
    db.close()
