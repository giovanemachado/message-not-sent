extends Node2D

var man_messages = [
	"good morning daughter. I'm so sorry for abandon you and", # 0
	"good morning daughter. I'm going to make my last delivery today. I'll see you tomorrow.",# 1
	"I didn't have a phone these last days, that’s why I didn't send anything before.", # 2
	"how is school? are you still the best? I remember you were", # 3
	"this job paid well, so I can go back now and live near you, try to get back that time, sorry for that", # 4
	"this job paid well, I'll come back this weekend and we can talk", # 5 
	"my god, this is blessing, I love you so much, how amazing I will be! I won't let anything else between us. this will be my last day here, and I'll be back to see you.", # 6 
]


# {  "character": "someone", "message": "...", "level": 1, "is_fake": true, "read": false }
var messages: Array[Dictionary] = [
	# boss messages
	{  
		"character": Globals.CHARACTERS.BOSS, 
		"message": "hey folk, delivery this super safe uraniun cargo and you are good to go to your vacation. thanks for these 4 years working 24/7, you are the best", 
		"level": 1,
		"read": false,
		"is_fake": true
	},
	
	# daughter messages
	{  
		"character": Globals.CHARACTERS.DAUGHTER, 
		"message": "where are you?", 
		"level": 1,
		"read": false,
		"is_fake": true  
	},
	{  
		"character": Globals.CHARACTERS.DAUGHTER, 
		"message": "wanna know, nvm, you can forget me.", 
		"level": 1,
		"read": false,
		"is_fake": true  
	},
	
	# man messages
	{  
		"character": Globals.CHARACTERS.MAN, 
		"message": "good morning daughter. I'm so sorry for abandon you and", 
		"level": 1,
		"read": false,
		"is_fake": true  
	},
	{  
		"character": Globals.CHARACTERS.MAN, 
		"message": "good morning daughter. I'm going to make my last delivery today. I'll see you tomorrow.", 
		"level": 1,
		"read": false,
		"is_fake": false  
	},
	
	# level 2
	# daughter messages
	{  
		"character": Globals.CHARACTERS.DAUGHTER, 
		"message": "ok", 
		"level": 2,
		"read": false,
	},
	
	# man messages
	{  
		"character": Globals.CHARACTERS.MAN, 
		"message": "I didn't have a phone these last days, that’s why I didn't send anything before.", 
		"level": 2,
		"read": false,
		"is_fake": false  
	},
	
	# level 3
	{  
		"character": Globals.CHARACTERS.BOSS, 
		"message": "small problem, your radar is broken, you can use the environments to keep moving right? gl", 
		"level": 3,
		"read": false,
		"is_fake": true
	},
]
