package main

import (
	"fmt"
	"log"
	"net/smtp"
	"os"

	"github.com/joho/godotenv"
)

func Send_email() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	smtpHost := os.Getenv("host")
	smtpPort := os.Getenv("port")
	email := os.Getenv("email")
	password := os.Getenv("password")

	subject := "Test email using GO"
	body := "This si a test email do not reply"
	message := []byte(subject + "\r\n" + body)

	to := []string{"dhruvkunzru@gmail.com"}

	auth := smtp.PlainAuth("", email, password, smtpHost)

	sendemail := smtp.SendMail(smtpHost+":"+smtpPort, auth, email, to, message)
	if sendemail != nil {
		log.Fatal(sendemail)
	}
	fmt.Print("Email sent")
}
