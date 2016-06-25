---
title: "Rep_Data Project 1"
author: "Pavel Kleyner"
date: "June 16, 2016"
output: html_document
---

**Loading and Preprocessing the Data:**



```r
setwd("C:/Users/Pavel/Documents/Coursera/Reproducible Research/Peer Assessment 1")
library(dplyr)
fit_data<-read.csv('activity.csv')
```

**What is mean total number of steps taken per day?**


```r
#group the data by date
fit_data_date_group<-group_by(fit_data,date)

#find sum for each day and plot in histogram
sums_steps_per_day<-summarise(fit_data_date_group,'Total Steps Per Day'=sum(steps,na.rm=TRUE))

hist(sums_steps_per_day$`Total Steps Per Day`,main='Frequency of Total Steps per day',xlab='Total Steps per day',breaks=100)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

```r
mean_steps<-mean(sums_steps_per_day$`Total Steps Per Day`,na.rm=TRUE)
mean_steps=round(mean_steps,3)
median_steps<-median(sums_steps_per_day$`Total Steps Per Day`,na.rm=TRUE)
```

The mean number of steps taken per day is 9354.23 and median number of steps taken per day is 10395.



**What is the average daily activity pattern?**


```r
fit_data_interval_group<-group_by(fit_data,interval)

average_steps_per_interval<-summarise(fit_data_interval_group,'Average Steps'=mean(steps,na.rm=TRUE))
```

Time Series Plot of Average Steps per Interval:


```r
plot(average_steps_per_interval$interval,average_steps_per_interval$`Average Steps`,type='l',main='Average Steps per Interval',xlab='Time Interval (min)',ylab='Average Steps')
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

```r
maxx<-max(average_steps_per_interval$`Average Steps`)
max_interval<-average_steps_per_interval$interval[average_steps_per_interval$`Average Steps`==maxx]
```

On average, the most steps are completed in the 5 minute time interval starting at 835.

**Imputing Missing Values:**


```r
num_na_vals<-table(is.na(fit_data$steps))[2]
```

Total number of missing (NA) values is 2304.


```r
#Imputing NA Values
#Strategy: Replace each NA value with the average for its 5 min time interval

#logical index of NA values in original data set
na_steps<-is.na(fit_data$steps)


#replicate average steps per interval vector to fill full span of original data set
full_avg_steps<-rep(average_steps_per_interval$`Average Steps`,times=nrow(fit_data)/nrow(average_steps_per_interval))

#find correct imputed values
fit_data[na_steps,1]<-full_avg_steps[na_steps]


#Imputed values Histogram
fit_data_grouped_imputed<-group_by(fit_data,date)

sums_steps_per_day_imputed<-summarise(fit_data_grouped_imputed,'Total Steps Per Day'=sum(steps))

hist(sums_steps_per_day_imputed$`Total Steps Per Day`,main='Frequency of Total Steps per day',xlab='Total Steps per day',breaks=100)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 


**Are there differences in activity patterns between weekdays and weekends?**


```r
fit_data_date<-fit_data$date
fit_data_date<-as.POSIXlt(fit_data_date,format="%Y-%m-%d")
weekdays_vec<-weekdays(fit_data_date)

days_factor_vec<-rep("weekday",times=nrow(fit_data))
days_factor_vec[weekdays_vec=="Saturday"|weekdays_vec=="Sunday"]="weekend"
days_factor_vec<-factor(days_factor_vec,labels=c("Weekday","Weekend"))

#combine weekday factor in with fit_data
fit_data<-cbind(fit_data,days_factor_vec)

#separate 'weekday' and 'weekend' sets for analysis
fit_data_weekday<-fit_data[fit_data$days_factor_vec=="Weekday",]
fit_data_weekday<-group_by(fit_data_weekday,interval)
fit_data_weekday<-summarise(fit_data_weekday,'Average Steps'=mean(steps))


fit_data_weekend<-fit_data[fit_data$days_factor_vec=="Weekend",]
fit_data_weekend<-group_by(fit_data_weekend,interval)
fit_data_weekend<-summarise(fit_data_weekend,'Average Steps'=mean(steps))



par(mfrow=c(1,2))
plot(fit_data_weekday$interval,fit_data_weekday$`Average Steps`,type='l',main='Weekday Values',xlab='Time Intervals (min)',ylab='Average Steps')
plot(fit_data_weekend$interval,fit_data_weekend$`Average Steps`,type='l',main='Weekend Values',xlab='Time Intervals (min)',ylab='Average Steps')
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 
