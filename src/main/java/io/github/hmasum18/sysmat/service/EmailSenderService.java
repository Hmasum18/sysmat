package io.github.hmasum18.sysmat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;

@Service
public class EmailSenderService {
    public static final String TAG = "EmailSenderService->";

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Autowired
    private JavaMailSender mailSender;

    public boolean sendSimpEmail(String toEmail, String body, String subject){
        String functionName = "sendSimpEmail(): ";

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setText(body);
        message.setSubject(subject);

        try{
            mailSender.send(message);
            System.out.println(TAG+functionName+"Mail sent successfully");
            return true;
        }catch (Exception e){
            System.out.println(TAG+functionName+e.getMessage());
            return false;
        }
    }

    public boolean sendEmailWithAttachment(String toEmail, String body
            , String subject, File attachment) throws MessagingException {
        String functionName = "sendEmailWithAttachment(): ";

        MimeMessage mimeMessage = mailSender.createMimeMessage();

        MimeMessageHelper mimeMessageHelper
                = new MimeMessageHelper(mimeMessage, true);
        mimeMessageHelper.setFrom("masumbuetcse18@gmail.com");
        mimeMessageHelper.setTo(toEmail);
        mimeMessageHelper.setText(body);
        mimeMessageHelper.setSubject(subject);

        FileSystemResource fileSystemResource
                = new FileSystemResource(attachment);

        mimeMessageHelper.addAttachment(fileSystemResource.getFilename(), fileSystemResource);

        try{
            mailSender.send(mimeMessage);
            System.out.println(TAG+functionName+"Mail sent successfully");
            return true;
        }catch (Exception e){
            System.out.println(TAG+functionName+e.getMessage());
            return false;
        }
    }
}
