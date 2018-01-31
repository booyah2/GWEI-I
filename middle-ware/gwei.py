import tweepy
import json
import npl

auth = tweepy.OAuthHandler("xssWkpCBfddkgdtr2nBLmyal2", "j9be4L6GBdoZnT6ApVNpX8NkfhcviEZholCXhS731keAq11xYT")
auth.set_access_token("49581021-ThqPOLx4USYTZX6YZZOGXmjUCof7XK66jKHhkXZqV", "cBP2XGpvRg7Mv4q3G6KwjyipU0X1y28FLhYr4TTX2BEJr")

api = tweepy.API(auth)

class MyStreamListener(tweepy.StreamListener):

    tweet_no = 32 

    def on_status(self, status):
        self.tweet_no += 1
        jsondump = json.dumps(status._json)
        fileName = "./tweets/" + str(self.tweet_no) + ".json"
        file = open(fileName, "w")
        file.write(jsondump)
        file.close() 
        npl.getSent(status.text)

myStreamListener = MyStreamListener()
myStream = tweepy.Stream(auth = api.auth, listener=myStreamListener)

myStream.filter(track=['#CapeTown'])