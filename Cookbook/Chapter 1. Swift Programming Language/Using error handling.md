# Using error handling

Suppose, you do some logic to request some data in a JSON format from a remote server and then you save this data in a local database. Can you imagine how many errors may happen for these operations? 

* Connection may fail between your app and the remote server
* failing to parse the JSON response
* database connection is closed
* database file doesn't exist
* another process is writing in database and you have to wait. 

Recovering from these errors allows you take the appropriate action based on the error type.


##### how to represent in errors

Swift provides you with a protocol called **Error** that your errors types should adopt.

    enum DBConnectionError: Error{ 
      case ConnectionClosed 
      case DBNotExist 
      case DBNotWritable 
    } 
    


##### Example

##### DEFINE

    enum SignUpUserError: Error{
    
        case InvalidFirstOrLastName
        case InvalidEmail
        case WeakPassword
        case PasswordsDontMatch
    
    }

    class SignUpUser {
    

        func signUpNewUserWithFirstName(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) throws{
            
            guard firstName.count > 0 && lastName.count > 0 else{
                
                throw SignUpUserError.InvalidFirstOrLastName
            }
            
            guard isValidEmail(email: email) else{
                throw SignUpUserError.InvalidEmail
            }
            
            guard password.count > 8 else{
                throw SignUpUserError.WeakPassword
            }
            
            guard password == confirmPassword else{
                throw SignUpUserError.PasswordsDontMatch
            }
            
            // Saving logic goes here
            
            print("Successfully signup user")
            
        }
    
        func isValidEmail(email:String) ->Bool {
            
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return predicate.evaluate(with: email)
        }    
    }


##### USE

     do{ 
         try signUpNewUserWithFirstName("John", lastName: "Smith", email: "john@gmail.com", password: "123456789", confirmPassword: "123456789") 
       } 
    catch{ 
         switch error{ 
           case SignUpUserError.InvalidFirstOrLastName: 
             print("Invalid First name or last name") 
           case SignUpUserError.InvalidEmail: 
             print("Email is not correct") 
           case SignUpUserError.WeakPassword: 
             print("Password should be more than 8 characters long") 
           case SignUpUserError.PasswordsDontMatch: 
             print("Passwords don't match") 
           default: 
             print(error) 
         } 
       } 



--

a list of guard statements that checks for user input; if any of these guard statements returned false, the code of else statement will be called. The statement throw is used to stop execution of this method and throw the appropriate error based on the checking made.

Catching errors is pretty easy;
to call a function that throws error, you have to call it inside the **do-catch block**. After the do statement, **use the try keyword and call your function**. If any error happens while executing your method, the block of code inside the catch statement will be called with a given parameter called error that represents the error.


##### Multiple catch statements

    catch SignUpUserError.InvalidFirstOrLastName{ 
     
    } 
    catch SignUpUserError.InvalidEmail{ 
     
    } 
    catch SignUpUserError.WeakPassword{ 
     
    } 
    catch SignUpUserError.PasswordsDontMatch{ 
     
    } 


After the do statement, you can list catch statement with the type of error that this statement will catch. Using this method has a condition that the catch statements should be exhaustive, which means it should **cover all types of errors**.



##### Disable error propagation

Swift gives you an option to **disable error propagation** via calling this method with try! instead of try.

