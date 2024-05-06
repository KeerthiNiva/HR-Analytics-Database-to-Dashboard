--create a join table--
Select * From [Work].[dbo].[Absenteeism_at_work] a
left join [Work].[dbo].[compensation] c
on a.ID = c.ID
left join [Work].[dbo].[Reasons] r
on  a.Reason_for_absence = r.Number;


--finding the healthiest employees for the bonus--
Select * From [Work].[dbo].[Absenteeism_at_work]
where [Social_drinker]=0 and [Social_smoker]=0 and Body_mass_index <25 
      and [Absenteeism_time_in_hours]< (Select AVG([Absenteeism_time_in_hours])
	                                    From [Work].[dbo].[Absenteeism_at_work])


--No of non-smokers--
Select count([ID]) As No_of_Nonsmokers 
From [Work].[dbo].[Absenteeism_at_work]
where [Social_smoker]=0;

--(no of non smokers:686)
--(hours worked by each employee in a year: 2080 hours per year)
--(hours worked by all employee in a year: 1,426,880 hours per year)
--(budget:$983,221)
--(Compensation increase for each hour: 983221/1426880 :$0.68 increase per hour)
--(Compensation increase for each employee: 2080 x 0.68 :$1414.4)
 


--comming back to the joint table and optimizing it--
Select a.[ID],r.[Reason],[Body_mass_index],
Case When [Body_mass_index]<18.5 Then 'Underweight'
     When [Body_mass_index] between 18.6 and 25 Then 'Normal Weight'
	 When [Body_mass_index] between 25.1 and 30 Then 'Overweight'
	 When [Body_mass_index]>30.1 Then 'Obese'
  Else 'Unknown' 
END as BMI_Category,[Month_of_absence],
CASE When [Month_of_absence] In (12,1,2) Then 'Winter'
     When [Month_of_absence] In (3,4,5) Then 'Spring'
     When [Month_of_absence] In (6,7,8) Then 'Summer'
     When [Month_of_absence] In (9,10,11) Then 'Fall'
     Else 'Unknown' 
END as Seasons, [Day_of_the_week],[Transportation_expense],[Education],[Son],[Social_drinker],[Social_smoker],[Pet],[Disciplinary_failure],[Age],[Absenteeism_time_in_hours],[Work_load_Average_day]
From [Work].[dbo].[Absenteeism_at_work] a
left join [Work].[dbo].[compensation] c
on a.ID = c.ID
left join [Work].[dbo].[Reasons] r
on  a.Reason_for_absence = r.Number;