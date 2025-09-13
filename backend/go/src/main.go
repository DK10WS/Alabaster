package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"github.com/markbates/goth"
	"github.com/markbates/goth/gothic"
	"github.com/markbates/goth/providers/google"
)

func main() {

	r := gin.Default()
	err := godotenv.Load()
	if err != nil {
		log.Fatal(".env file failed to load!")
	}
	clientID := os.Getenv("CLIENT_ID")
	clientSecret := os.Getenv("CLIENT_SECRET")
	callBack := os.Getenv("CALLBACK")

	goth.UseProviders(
		google.New(clientID, clientSecret, callBack),
	)

	r.GET("/", home)
	r.GET("/auth/:provider", sign_in)
	r.GET("/auth/:provider/callback", callbackHandler)
	r.GET("/success", Success)

	err = r.Run(":8000")
	if err != nil {
		log.Fatal(err)
	}

}
func home(c *gin.Context) {
	tmpl, err := template.ParseFiles("static/index.html")
	if err != nil {
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	err = tmpl.Execute(c.Writer, gin.H{})
	if err != nil {
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
}

func sign_in(c *gin.Context) {
	provider := c.Param("provider")
	q := c.Request.URL.Query()
	q.Add("provider", provider)
	c.Request.URL.RawQuery = q.Encode()
	gothic.BeginAuthHandler(c.Writer, c.Request)

}

func callbackHandler(c *gin.Context) {

  provider := c.Param("provider")
  q := c.Request.URL.Query()
	q.Add("provider", provider)
	c.Request.URL.RawQuery = q.Encode()

  
  _, err := gothic.CompleteUserAuth(c.Writer, c.Request)
  if err != nil {
      c.AbortWithError(http.StatusInternalServerError, err)
      return
  }

  c.Redirect(http.StatusTemporaryRedirect, "/success")
}
func Success(c *gin.Context) {

	c.Data(http.StatusOK, "text/html; charset=utf-8", []byte(fmt.Sprintf(`
      <div style="
          background-color: #fff;
          padding: 40px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          text-align: center;
      ">
          <h1 style="
              color: #333;
              margin-bottom: 20px;
          ">You have Successfull signed in!</h1>
          
          </div>
      </div>
  `)))
}
