If your iOS project has multiple environments, you might think about how to switch them easily. 

- Think about the below scenario: 
You have multiple teams to work on the same iOS project and each team has its microservice which deploys in different environments.
```
- SIT
- UAT
- PERF
- PROD
```
When the iOS developers are doing the development and QA are validating the testing build, they want an easy way to switch from each environment.  Preference Items should be a good way for you to accommodate this target.

![Preference Items.jpg](https://github.com/RENCHILIU/iOS/blob/master/SwitchEnvDemoApp/Preference%20Items.jpg?raw=true)


First, let us have a a new setting buddle

![newfile](https://github.com/RENCHILIU/iOS/blob/master/SwitchEnvDemoApp/newfile.png?raw=true)

Then, add below setting to the root.plist file
![setting config](https://github.com/RENCHILIU/iOS/blob/master/SwitchEnvDemoApp/setting%20config.png?raw=true)

Use below code to read the value from your settings and you will be able to switch multiple environments.

![read file](https://github.com/RENCHILIU/iOS/blob/master/SwitchEnvDemoApp/readthe%20value.png?raw=true)