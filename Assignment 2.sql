#1
alter table survey_responders add column last_modified DATETIME;

#2
alter table survey_responders add column username VARCHAR(20);

#3
alter table survey_questions add column last_modified DATETIME;

#4
alter table survey_responses add column survey_question_responder_id INT UNSIGNED;

#5
update survey_responders set username = concat(left(first_name, 1), last_name);

#6.7
create view vw_average_responses as
select avg(survey_response) from survey_responses;

#6.8
create view vw_question_average_resp as
select survey_question_id, avg(survey_response) from survey_responses group by survey_question_id;

#6.9
create view vw_responders_question_1 as
select first_name, last_name, email, province, last_survey_date from survey_responders
	join survey_responses on (survey_responses.survey_responder_id = survey_responders.id)
	where survey_responses.survey_question_id = 1;

#6.10
create view vw_avganswers_ontario as
select province, avg(survey_response) from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	where province = 'Ontario';

#6.11
create view vw_avganswer_perquestions_ontario as
select province, question, avg(survey_response) as average from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	where survey_responders.province = 'Ontario'
	group by question;

#6.12
create view vw_avganswers_perprovince as
select province, question, avg(survey_response) as average from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	group by province, question;

#7
delimiter $$
create trigger tr_before_modifie_responders
	before update on survey_responders
	for each row begin
	set new.last_modified = now();
end $$
delimiter ;

#8
delimiter $$
create trigger tr_before_modifie_questions
	before update on survey_questions
	for each row begin
	set new.last_modified = now();
end $$
delimiter ;

#9
delimiter $$
create trigger tr_delete_responder
	after delete on survey_responders
	for each row
	begin
		delete from survey_responses where survey_responder_id = old.id;
	end $$
delimiter ;