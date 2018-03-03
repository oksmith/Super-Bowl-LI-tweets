q<-paste0("patriots,pats,patriotsnation,falcons,dirty birds,riseup")
  #change these keywords if you're searching for something else

streamtime<-60*60*4  
  #stream for 4 hours

filename<-file.path(
  rtweet.folder,paste0(format(Sys.time(),"%F-%H-%S"),".json")
)
metadata<-paste0("q=",q,"\n",
                 "streamtime=",streamtime,"\n",
                 "filename=",filename)
metafile<-gsub(".json$",".txt",filename)

cat(metadata,file=metafile)
  #now we have generated the file to be used to stream stuff

stream_tweets(q=q, timeout=streamtime, file_name=filename, parse=FALSE)
  #this streams the tweets

superbowl<-parse_stream(filename)
superbowl %>%
  ts_filter(by="secs", 
            filter=c("patriots|new england|pats","falcons|dirty birds|atlanta"),
            key=c("Patriots","Falcons"),
            trim=TRUE)%>%
  ts_plot(theme="spacegray",cols=c("#6699ee","#dd7a7a"),main="Tweets streamed about Super Bowl LI")
  #this plots the tweets so we can visualise the pattern of popularity of Falcons vs Patriots

#if you're having trouble with margins
#set par(mar=c(1,1,1,1))
