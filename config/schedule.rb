require "tzinfo"

def local(time)
    TZInfo::Timezone.get('Asia/Seoul').local_to_utc(Time.parse(time))
end

every 10.minutes do
    rake "jobs:auto_runner_job", :environment => "development"
    rake "jobs:auto_runner_job", :environment => "production"
end

every 1.minutes do
    rake "test:kcm", :environment => "production"
    rake "test:kcm", :environment => "development"
end
## 스케쥴링 Job 테스트 : 1분 간격으로 Bussiness 모델에 새로운 데이터를 생성합니다.
# every 1.minutes do
#     rake "scheduling_job_test:make_business", :environment => "development"
# end

## 스케쥴링 Job 테스트 : 10분(whenever을 킨 기준이 아닌 0분, 10분, 20분, ..., 50분) 간격으로 Bussiness 모델에 새로운 데이터를 생성합니다.
# every 10.minutes do
#     rake "scheduling_job_test:make_business", :environment => "development"
# end