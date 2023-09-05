import twilio from "twilio";
import dotenv from "dotenv";

dotenv.config();
const config = process.env;

class TwilioService {
    constructor() {
        this.client = twilio(config.TWILIO_ACCOUNT_SID, config.TWILIO_AUTH_TOKEN);
    }

    async sendMessage(message_data) {
        console.log("Twilio service used")
        console.log(message_data.message)
        console.log(message_data.phone)
        await this.client.messages.create({
            body: message_data.message,
            to: `+84${message_data.phone}`, // Text your number
            from: '+13344906324', // From a valid TwilioService number
        })
    }
}

export default TwilioService;