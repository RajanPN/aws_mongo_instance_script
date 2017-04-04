## AWS EC2 MongoDB instance setup script

##### Amazon EC2 Instance Details

	Step 1: Choose an Amazon Machine Image (AMI)

			Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-a58d0dc5

	Step 2: Choose an Instance Type
			
			Type - t2.small
	Step 3: Configure Instance Details
			
			Enable termination protection - Enable

	Step 4: Add Storage
			
			Size : 8GB
			Volume Type: General Purpose SSD(GP2)
			Delete on Termination = disable
	
	Step 5: Add Tags
			
			Name : mongodb
	
	Step 6: Configure Security Group
			
			Security Group Name : mongodb-security-group
			Security Group Rules:
			  - Type: http , Protocol: tcp, Port Range: 80, source: anywhere
			  - Type: Custom TCP Rule , Protocol: tcp, Port Range: 27017, source: anywhere
			  - Type: Custom TCP Rule , Protocol: tcp, Port Range: 28017, source: anywhere
			  - Type: SSH , Protocol: TCP, Port Range: 22, source: anywhere


##### Amazon EC2 Instance Connection

	Use the pem used for instance creation

```
	$ ssh -i filename.pem ubuntu@hostip
```

##### Amazon EC2 Instance Configuration Details

	Make sure all the packages and security packages are updated

```
	$ sudo apt-get update &&  sudo apt-get dist-upgrade -y
	$ sudo reboot
```

##### Configure MongoDB username and password
	
```
	$ mongo
	
	In mongoDB shell
	> use admin
	> db.createUser({user:"sanocare", pwd:"sanocare123", roles:[{role:"root", db:"admin"}]})

```

##### Enable mongodb authentication


###### Changes in service file "mongod.service"

	
```
	$ sudo nano /lib/systemd/system/mongod.service
	
	Before :
	--------
		
		ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

	After :
	-------

		ExecStart=/usr/bin/mongod --quiet --auth --config /etc/mongod.conf


```

###### Changes in mongodb config file "mongod.conf"
	
```
	$ sudo nano /etc/mongod.conf
	
	Before :
	--------
		
		bindIp : 127.0.0.1

	After : [Add the host ip addresses using the mongo instance ]
	-------


		bindIp: [127.0.0.1, ***************]


```

##### Amazon EC2 Instance Configuration Details

	Make sure all the packages and security packages are updated

```
	$ sudo apt-get update &&  sudo apt-get dist-upgrade -y
	$ sudo reboot
```

##### MongoDB connection options details
	
```
	db_url: 'mongodb://[host ip address]:27017/sanocare',

 	 options: {
   		auth: {
      		authdb: 'admin'
  		},
    	server: {
      		socketOptions: {
        		keepAlive: 1
      		}
    	},
    	user: 'sanocare',
    	pass: 'sanocare123' // .env file can be used for password
	}


```

