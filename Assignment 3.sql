Question 1
select count(*) from survey_responders

Question 2
select * from survey_responders

Question 3
select count(*) from survey_questions

Question 4
select question from survey_questions

Question 5
select count(province) from survey_responders where province = 'Alberta'

Question 6
select count(survey_response) from survey_responses where survey_response = 4

Question 7
select avg(survey_response) from survey_responses

Question 8
select survey_question_id, avg(survey_response) from survey_responses group by survey_question_id

Question 9
select first_name, last_name, email, province, last_survey_date from survey_responders
	join survey_responses on (survey_responses.survey_responder_id = survey_responders.id)
	where survey_responses.survey_question_id = 1

Question 10
select province, avg(survey_response) from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	where province = 'Ontario'

Question 11
select province, question, avg(survey_response) as average from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	where survey_responders.province = 'Ontario'
	group by question

Question 12
select province, question, avg(survey_response) as average from survey_responders
	join survey_responses on (survey_responder_id = survey_responders.id)
	join survey_questions on (survey_questions.id = survey_responses.survey_question_id)
	group by province, question