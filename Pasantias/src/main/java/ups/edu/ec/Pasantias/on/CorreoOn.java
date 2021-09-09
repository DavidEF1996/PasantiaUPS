package ups.edu.ec.Pasantias.on;


import javax.ejb.Stateless;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Stateless
public class CorreoOn {

	public static  void sendMail(String destino,String Asunto,String CuerpoMail) throws Exception {
		String senderEmail = "noticiaspolitecnicasalesiana@gmail.com";// change with your sender email
		String senderPassword = "noticiasups";// change with your sender password

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");// Outgoing server requires authentication
		props.put("mail.smtp.starttls.enable", "true");// TLS must be activated
		props.put("mail.smtp.host", "smtp.gmail.com"); // Outgoing server (SMTP) - change it to your SMTP server
		props.put("mail.smtp.port", "587");// Outgoing port
		//props.put("m", arg1)

//				mail.smtp.host=smtp.gmail.com, 
//				mail.smtp.port=25,
//				mail.smtp.auth=true 
//				mail.smtp.starttls.enable=true
				
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderEmail, senderPassword);
			}
		});
		Message message = prepareEmailMessage(session, senderEmail, destino,Asunto,CuerpoMail);
	
		Transport.send(message);
		System.out.println("se envio el mensaje");
	}

	private static Message prepareEmailMessage(Session session, String senderEmail, String destino,String Asunto,String CuerpoMail) {
		try {
			Message message = new MimeMessage(session);
			// message.setContent(html, "text/html; charset=utf-8");
			message.setFrom(new InternetAddress(senderEmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destino));
			message.setSubject(Asunto);
			message.setText(CuerpoMail);
			return message;
		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	
}
