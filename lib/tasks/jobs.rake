namespace :jobs do
  desc "TODO"
  task auto_runner_job: :environment do
    
    ## Job 모델에서 현재 시간 조건에 맞는 일들을 모두 찾아낸다 (사용자들은 사전에 part_time_job_time 이라는 애트리뷰트에 알바시간을 기록한다.)
    #@ready_job = Job.where(part_time_job_time: Time.zone.now.strftime('%H:%M'))
   
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    dateTime = Time.zone.now.strftime('%Y-%m-%d %H:%M:00').to_s
    puts "dateTime: #{dateTime}"
    
    ## ActiveJob
    # 나중에 sidekiq을 통해 Background Job을 하게되면 perform_now가 아니라 perform_later 로 메소드 수정해주세요!
    CheckTimeJob.perform_now(dateTime)
    
  end
  
  

end