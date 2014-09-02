//  Led parameters
int ledPin[3] = { 6 , 3 , 5 };
int ledColor[3] = { 0xF2 , 0x00 , 0xFF };
int ledBrightness = 30;
bool ledState = true;

//  Client command
String command;

//  Updates the PWM signal on led pins to match requested color and brightness
void updateLedColor()
{
  
    //  The LED is switched on
    if ( ledState == true )
    {
      
        //  Write color values corrected by the brightness coefficient to the LED pins
        analogWrite(ledPin[0],ledColor[0]*ledBrightness/100);
        analogWrite(ledPin[1],ledColor[1]*ledBrightness/100);
        analogWrite(ledPin[2],ledColor[2]*ledBrightness/100);
        
    }
    
    //   The LED is switched off
    else
    {
      
        //  Write zeros to all LED pins
        analogWrite(ledPin[0],0);
        analogWrite(ledPin[1],0);
        analogWrite(ledPin[2],0);
        
    }
    
}

//  Initializes the serial port
void setup()
{
  
    //  Initialize serial port
    Serial.begin(9600);

    //  Switch on the LED with default color and brightness    
    updateLedColor();
    
}

//  Reads commands from serial port and updates led color and brightness
void loop()
{

    //  While there is some data on the serial port
    while ( Serial.available() )
    {

        //  Read one character from the serial port
        int character = Serial.read();

        //  Full command received
        if ( character == '\n' )
        {

            //  Client requested to switch the LED on
            if ( command == "ON" )
            {
                ledState = true;
                updateLedColor();
            }

            //  Client requested to switch the LED off
            else if ( command == "OFF" )
            {
                ledState = false;
                updateLedColor();
            }

            //  Client requested to alter the LED brightness
            else if ( command.startsWith("BRIGHTNESS:") )
            {
                command.replace("BRIGHTNESS:","");
                ledBrightness = command.toInt();
                updateLedColor();
            }

            //  Client requested to alter the LED color
            else if ( command.startsWith("COLOR:") )
            {
                command.replace("COLOR:","");
                ledColor[0] = ( "0x" + command.substring(0,1) ).toInt();
                ledColor[1] = ( "0x" + command.substring(2,3) ).toInt();
                ledColor[2] = ( "0x" + command.substring(4,5) ).toInt();
                updateLedColor();
            }

            // Command was processed or ignored
            command = "";

        }
        
        //  The command was not received completely yes
        else
        {
          
          //  Add the character to the command
          command += (char)character;
          
        }

    }
}
