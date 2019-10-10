class ActiveController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index1
    @job = Job.where(status: 'open')
    for i in 0..@job.length - 1
      @job[i].pay = insert_comma(@job[i].pay.to_i)
      @job[i].time_start = @job[i].time_start[10..15]
      @job[i].time_end = @job[i].time_end[10..15]
    end
    @favorites = Favorite.where(user_id: current_user.id)
    
    @job = @job.to_json
    
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).to_json
    puts @tag
  end
  
  def selectTag
    job_id = params[:job_id]
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).where(job_id: job_id)
    puts "----------------------------------------------------"
    puts @tag
    return tag
  end
  
  def geo_list
    @job = Job.all.to_json
    @y = params[:y]
    @x = params[:x]
  end
  
  def create_application
    @application = Application.where(user_id: current_user.id, job_id: params[:id]).where.not(status: 'cancel').to_json
    
    @job = Job.find(params[:id])
    start_date = Time.parse @job.time_start
    end_date =  Time.parse @job.time_end
    pay = (end_date - start_date) / 60 / 60 * @job.pay.to_i
    @payment = insert_comma(pay.to_i) #예상지급
    
    @job.pay = insert_comma(@job.pay.to_i)
    @job.time_start = @job.time_start[10..15]
    @job.time_end = @job.time_end[10..15]
    
    @bussiness = Bussiness.find(@job.bussiness_id)
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).where(job_id: params[:id])
  end
  
  def createApplication
    @application = Application.new
    @application.user_id = current_user.id
    @application.job_id = params[:job_id]
    @application.status = 'appried'
    @application.save
    
    @job = Job.find(params[:job_id])
    @job.personnel_cnt = @job.personnel_cnt + 1
    @job.save
    
    redirect_to '/active/create_application?id=' + params[:job_id]
  end
  
  def create_favorites
    
  end
  
  def createFavorites
    @favorites = Favorite.new
    @favorites.y = params[:y]
    @favorites.x = params[:x]
    @favorites.user_id = current_user.id
    @favorites.save
    
    redirect_to '/active/index1'
  end
  
  def list_application
    #지원중, 진행중
    @application = Application.select('jobs.*, applications.*').joins(:job).where(user_id: current_user.id, status: 'hired').or(Application.select('jobs.*, applications.*').joins(:job).where(user_id: current_user.id, status: 'appried'))
    for i in 0..@application.length - 1
      start_date = Time.parse @application[i].time_start
      end_date =  Time.parse @application[i].time_end
      pay = (end_date - start_date) / 60 / 60 * @application[i].pay.to_i
      
      @application[i].pay = insert_comma(@application[i].pay.to_i)
      @application[i].time_start = @application[i].time_start[10..15]
      @application[i].time_end = @application[i].time_end[10..15]
      
    end
    
    #마감
    @application_end = Application.select('jobs.*, applications.*').joins(:job).where(user_id: current_user.id, status: 'completed')
    
    @total_pay = 0;
    @total_time = 0;
    for i in 0..@application_end.length - 1
      start_date = Time.parse @application_end[i].time_start
      end_date =  Time.parse @application_end[i].time_end
      pay = (end_date - start_date) / 60 / 60 * @application_end[i].pay.to_i
      
      @application_end[i].pay = insert_comma(@application_end[i].pay.to_i)
      @application_end[i].time_start = @application_end[i].time_start[10..15]
      @application_end[i].time_end = @application_end[i].time_end[10..15]
      
      #근무시간
      @total_time += (end_date - start_date) / 60
      
      #총 알바비
      @total_pay += pay
    end
    
    @total_time = @total_time.to_i
    @total_pay = insert_comma(@total_pay.to_i)
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag)
    
    
  end
  
  def appriedCancel
    @application = Application.find(params[:id])
    @application.status = 'cancel'
    @application.save
    
    @job = Job.find(@application.job_id)
    @job.personnel_cnt = @job.personnel_cnt - 1
    @job.save
  end
  
  def progress_application
    @application = Application.where(user_id: current_user.id, job_id: params[:id]).where.not(status: 'cancel').to_json
    
    @job = Job.find(params[:id])
    start_date = Time.parse @job.time_start
    end_date =  Time.parse @job.time_end
    pay = (end_date - start_date) / 60 / 60 * @job.pay.to_i
    @payment = insert_comma(pay.to_i) #예상지급
    
    @job.pay = insert_comma(@job.pay.to_i)
    @job.time_start = @job.time_start[10..15]
    @job.time_end = @job.time_end[10..15]
    
    @bussiness = Bussiness.find(@job.bussiness_id)
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).where(job_id: params[:id])
  end
  
  def deadline_application
    @application = Application.where(user_id: current_user.id, job_id: params[:id]).where.not(status: 'cancel').to_json
    
    @job = Job.find(params[:id])
    start_date = Time.parse @job.time_start
    end_date =  Time.parse @job.time_end
    pay = (end_date - start_date) / 60 / 60 * @job.pay.to_i
    @payment = insert_comma(pay.to_i) #예상지급
    
    @job.pay = insert_comma(@job.pay.to_i)
    @job.time_start = @job.time_start[10..15]
    @job.time_end = @job.time_end[10..15]
    
    @bussiness = Bussiness.find(@job.bussiness_id)
    @tag = Tag.select('lib_tags.*, tags.*').joins(:lib_tag).where(job_id: params[:id])
  end
  
  def insert_comma(string)
      return string.to_s(:delimited)
  end
end
