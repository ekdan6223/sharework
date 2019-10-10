class CheckTimeJob < ApplicationJob
  queue_as :job_run
 
  def perform(dateTime)
    #알바 시작
    job = Job.where(time_start: dateTime)#.update_all(status: 'start')
    
    for i in 0..job.length - 1
      cnt_app = Application.where(job_id: job[i].id, status: 'hired').count
      j = Job.find(job[i].id)
      if cnt_app > 0
        j.status = 'start'
      elsif cnt_app == 0
        j.status = 'close'
      end
      j.save
      
      Application.where(job_id: job[i].id, status: 'appried').update_all(status: 'failed')
    end
    
    #알바 종료
    Job.where(time_end: dateTime).update_all(status: 'close')
    job = Job.where(time_end: dateTime)
    
    for i in 0..job.length - 1
      Application.where(job_id: job[i].id, status: 'hired').update_all(status: 'completed')
    end
      
    #puts "** ActiveJob 수행내역 결과 :: job_list : #{job_list}"
  end
end
