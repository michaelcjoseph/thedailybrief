require_relative '../email_helpers/email_content'

module WelcomeEmail
  def WelcomeEmail.get_html_content
    unsubscribe_content = EmailContent.get_unsubscribe_text

    html_content = "
      <html>
        <head>
          <meta name=\"viewport\" content=\"width=device-width\">
          <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">
          <title>Welcome to The Daily Brief</title>
        </head>
        <body class=\"email-base\" bgcolor=\"#FFFFFF\" style=\"font-family: Helvetica, Arial, sans-serif; margin: 0; padding: 0; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; color: #444444; height: 100%; width: 100% !important; font-size: 16px;\">
          <table cellspacing=\"0\" style=\"font-family:\'Open Sans\',Helvetica, Arial, sans-serif; margin: 0; padding: 0; width: 100%;\">
            <tr>
              <td align=\"center\" style=\"vertical-align: top;\">
                <table class=\"body-table\" cellspacing=\"0\" style=\"margin: 0; padding: 25px; width: 600px;\">
                  <tbody>
                    <tr>
                      <td height=\"65\"></td>
                    </tr>
                    <tr>
                      <td>
                        <a href=\"www.thedailybrief.co\" style=\"display:block;float:left\" target=\"_blank\">
                          <img src=\"http://www.thedailybrief.co/logo.png\" border=\"0\">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td height=\"65\"></td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\',Helvetica,Arial,sans-serif;font-size:1.375em;font-weight:700;color:rgb(10,10,10);line-height:1.85em\">Hi {{name}}!</td>
                    </tr>
                    <tr>
                      <td height=\"30\"></td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\',Helvetica,Arial,sans-serif;font-size:1.375em;color:rgb(40,40,40);line-height:1.85em\">Thanks for signing up for The Daily Brief! Every morning, you\'ll get an email from me with some of the most interesting articles and podcasts from the day before. You can also check the <a href=\"http://www.thedailybrief.co\" style=\"text-decoration: none;color:rgb(0,191,145);\">site</a> for even more. I hope you\'ll find them as engaging as I do.</td>
                    </tr>
                    <tr>
                      <td height=\"30\"></td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\',Helvetica,Arial,sans-serif;font-size:1.375em;color:rgb(40,40,40);line-height:1.85em\">If you have a moment, I\'d love it if you could answer a quick question: why did you sign up for The Daily Brief?</td>
                    </tr>
                    <tr>
                      <td height=\"30\"></td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\',Helvetica,Arial,sans-serif;font-size:1.375em;color:rgb(40,40,40);line-height:1.85em\">I want to make sure the newsletter and site are delivering exactly what you want, and this is the best way to do that. Just hit \"Reply\" and let me know!</td>
                    </tr>
                    <tr>
                      <td height=\"30\"></td>
                    </tr>
                    <tr>
                      <td>
                        <div style=\"width:70px;min-height:1px;background-color:rgb(224,224,224);background-position:initial initial;background-repeat:initial initial\"></div>
                      </td>
                    </tr>
                    <tr>
                      <td height=\"30\"></td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\'Italic,Helvetica,Arial,sans-serif;font-style:italic;font-size:1.188em;color:rgb(40,40,40);line-height:1.85em\">Thanks for your time!</td>
                    </tr>
                    <tr>
                      <td style=\"font-family:\'Open Sans\'Italic,Helvetica,Arial,sans-serif;font-style:italic;font-size:1.188em;color:rgb(40,40,40);line-height:1.85em\">{{sender}}</td>
                    </tr>
                    <tr>
                      <td height=\"100\"></td>
                    </tr>
                    <tr>
                      <td style=\"border-top-width:1px;border-top-style:solid;border-top-color:rgb(224,224,224)\">
                        <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">
                          <tbody>
                            <tr>
                              <td height=\"35\"></td>
                            </tr>
                            <tr>
                              <td style=\"text-align:center;font-family:\'Open Sans\',Helvetica,Arial,sans-serif;font-size:1.188em;color:rgb(40,40,40);line-height:1.85em\">
                                #{unsubscribe_content}
                              </td>
                            </tr>
                            <tr>
                              <td height=\"35\"></td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </table>
        </body>
      </html>
    "

    return html_content
  end
end