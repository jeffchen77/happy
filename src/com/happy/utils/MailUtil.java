package com.happy.utils;

import java.io.File;
import java.io.StringWriter;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.happy.conf.ConfFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class MailUtil {
	public static String MAIL_HOST=ConfFactory.getConf().get("mail.host","smtp.sina.com");
	public static String MAIL_AUTH=ConfFactory.getConf().get("mail.auth","true");
	public static String MAIL_PORT=ConfFactory.getConf().get("mail.port","25");
	public static String MAIL_USER=ConfFactory.getConf().get("mail.user","qiniugongzuoshi@sina.com");
	public static String MAIL_PWD=ConfFactory.getConf().get("mail.password","qiniuno.1");
	
	public static String MAIL_DRE=ConfFactory.class.getResource("/com/happy/template").getFile();
	
	public static String MAIL_SUBJECT=ConfFactory.getConf().get("mail.subject","通知邮件---朕以为");
	
	protected static Log LOG = LogFactory.getLog(MailUtil.class);
	
	public static void SendMail(List<String> recipients, String subject,
			String content) throws Exception {
		if(content==null || "".equalsIgnoreCase(content) || recipients==null || recipients.size()<1)
		{
			return;
		}
		Properties props = new Properties();
		props.put("mail.smtp.host", MAIL_HOST);
		props.put("mail.smtp.auth", MAIL_AUTH);
		props.put("mail.smtp.port", MAIL_PORT);

		Session mailSession = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(MAIL_USER,
						MAIL_PWD);
			}
		});

		MimeMessage message = new MimeMessage(mailSession);
		int index=0;
		message.setFrom(new InternetAddress(MAIL_USER));

		InternetAddress[] addresses = new InternetAddress[recipients.size()];
		for (int i = 0; i < recipients.size(); i++) {
			if(recipients.get(i)!=null)
			{
			addresses[index] = new InternetAddress(recipients.get(i));
			index++;
			}
		}
		if(addresses !=null && addresses.length>0)
		{
		message.setRecipients(RecipientType.BCC, addresses);

		message.setSentDate(Calendar.getInstance().getTime());
		message.setSubject(subject);
		message.setContent(content, "text/html;charset=utf-8");

		message.saveChanges();
		// 第三步：发送消息
		Transport.send(message);	
		}
	}

	public static String generateContent(Map<String, String> map, String ftl) 
	{
		try 
		{
			Configuration freemarkerConfiguration = new Configuration();
			LOG.debug("mail dir:"+MAIL_DRE);
			File f = new File(MAIL_DRE);
			freemarkerConfiguration.setDirectoryForTemplateLoading(f);
			Template template = freemarkerConfiguration.getTemplate(ftl,
					"utf-8");
			StringWriter result = new StringWriter();
			template.process(map, result);
			return result.toString();
		} catch (Exception e) {
			e.printStackTrace();
			LOG.debug(e.getMessage());
		}
		return null;
	}

}
