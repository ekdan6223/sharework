class BussinessController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @bussiness = Bussiness.find_by(user_id: current_user.id, state: 'Y')
    if @bussiness != nil
      #진행중
      @job = Job.where(bussiness_id: @bussiness.id, status: 'open').or(Job.where(bussiness_id: @bussiness.id, status: 'start'))
      for i in 0..@job.length - 1
        @job[i].pay = insert_comma(@job[i].pay.to_i)
        @job[i].time_start = @job[i].time_start[10..15]
        @job[i].time_end = @job[i].time_end[10..15]
      end
      
      #마감
      @job_end = Job.where(bussiness_id: @bussiness.id, status: 'close')
      for i in 0..@job_end.length - 1
        @job_end[i].pay = insert_comma(@job_end[i].pay.to_i)
        @job_end[i].time_start = @job_end[i].time_start[10..15]
        @job_end[i].time_end = @job_end[i].time_end[10..15]
      end
      
      @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).where(bussiness_id: @bussiness.id)
      puts "----------------------------------------------------"
      
      
    end
  end
  
  def location
  end

  def create
    @bussiness = Bussiness.where(user_id: current_user.id).update_all(state: 'N')
    
    @bussiness = Bussiness.new
    @bussiness.bs_name = params[:bs_name]
    @bussiness.address = params[:address]
    @bussiness.phone = params[:phone]
    @bussiness.y = params[:y]
    @bussiness.x = params[:x]
    @bussiness.user_id = current_user.id
    @bussiness.state = 'Y'
    @bussiness.save
    
    redirect_to '/bussiness/index'
  end
  
  def change_bs
    @bussiness = Bussiness.where(user_id: current_user.id)
  end
  
  def change
    @bussiness = Bussiness.where(user_id: current_user.id).update_all(state: 'N')
    
    @bussiness = Bussiness.find(params[:id])
    @bussiness.state = 'Y'
    @bussiness.save
    
    redirect_to '/bussiness/index'
  end
  
  def create_job
    @bussiness = Bussiness.find(params[:id])
    @lib_tag = LibTag.all
  end
  
  def createJob
    @job = Job.create(
      bussiness_id: params[:bussiness_id],
      date: params[:date],
      time_end: params[:time_end],
      time_start: params[:time_start],
      pay: params[:pay],
      bs_name: params[:bs_name],
      address: params[:address],
      phone: params[:phone],
      y: params[:y],
      x: params[:x],
      etc: params[:etc],
      personnel: params[:personnel],
      personnel_cnt: 0,
      day_payment: params[:day_payment],
      status: 'open'
    )
    
    @sel_tag = JSON.parse(params[:data])
    
    counter = 0
    while counter < @sel_tag.length
      @tag = Tag.new(job_id: @job.id)
      @tag.lib_tag_id = @sel_tag[counter]["id"]
      @tag.bussiness_id = params[:bussiness_id]
      @tag.save
      counter = counter + 1
    end
    
    redirect_to '/bussiness/index'
  end
  
  def show_job
    @job = Job.find(params[:id])
    
    start_date = Time.parse @job.time_start
    end_date =  Time.parse @job.time_end
    pay = (end_date - start_date) / 60 / 60 * @job.pay.to_i
    @payment = insert_comma(pay.to_i) #예상지급
    
    @job.pay = insert_comma(@job.pay.to_i)
    @job.time_start = @job.time_start[10..15]
    @job.time_end = @job.time_end[10..15]
    
    @application = Application.select('users.*, applications.*').joins(:user).where(job_id: @job.id).where.not(status: 'cancel')
    
  end
  
  def show_applicant
    @job = Job.find(params[:id])
    @application = Application.select('users.*, applications.*').joins(:user).where(job_id: @job.id)
  end
  
  def hiredApplication
    application = Application.select('jobs.*, applications.*').joins(:job).find_by(user_id: params[:user_id], job_id: params[:job_id])
    application.status = "hired"
    application.save
    
    application_applied = Application.select('jobs.*, applications.*').joins(:job).where(user_id: params[:user_id], status: 'appried', jobs: {date: application.date})
    
    for i in 0..application_applied.length - 1
      start_date = Time.parse application.time_start
      end_date = Time.parse application.time_end
      diff_start_date = Time.parse application_applied[i].time_start
      diff_end_date = Time.parse application_applied[i].time_end
      
      app = Application.find(application_applied[i].id)
      if start_date <= diff_start_date && diff_start_date <= end_date
        app.status = 'rejected'
      end
      if start_date <= diff_end_date && diff_end_date <= end_date
        app.status = 'rejected'
      end
      if diff_start_date <= start_date && diff_end_date >= end_date
        app.status = 'rejected'
      end
      app.save
      #tStartA < tStartB && tStartB < tEndA //For case 1
      #OR
      #tStartA < tEndB && tEndB <= tEndA //For case 2
      #OR
      #tStartB < tStartA  && tEndB > tEndA //For case 3
    end
    
    
    
  end

  def insert_comma(string)
      return string.to_s(:delimited)
  end
end
