class ErrorMailer < ApplicationMailer
  def error_details(url, error, exception_wrapper, trace)
    @url = url
    @error = error
    @exception_wrapper = exception_wrapper
    @trace = trace
    @message = error.nil? ? "No Error" : error.message
    mail to: "trickswebmaster@gmail.com", subject: "Website Error: " + @message
  end

end
