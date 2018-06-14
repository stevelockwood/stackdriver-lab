invoke-webrequest https://dl.google.com/cloudagents/windows/StackdriverLogging-v1-8.exe -OutFile StackdriverLogging-v1-8.exe
.\StackdriverLogging-v1-8.exe /s
invoke-webrequest https://repo.stackdriver.com/windows/StackdriverMonitoring-GCM-46.exe -OutFile StackdriverMonitoring-GCM-46.exe
.\StackdriverMonitoring-GCM-46.exe /s