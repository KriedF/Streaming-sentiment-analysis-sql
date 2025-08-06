-- Advanced User Satisfaction Analysis
-- This query demonstrates data linkage - connecting survey responses with user demographics
-- Business Question: Do different user segments have different satisfaction patterns?

SELECT 
    d.age_group,
    d.subscription_type,
    s.question_id as feature,
    COUNT(s.response_id) as number_of_responses,
    ROUND(AVG(s.rating_score), 2) as avg_satisfaction,
    -- Calculate Net Promoter Score style metric
    ROUND(
        (COUNT(CASE WHEN s.rating_score = 5 THEN 1 END) * 100.0) / COUNT(*) - 
        (COUNT(CASE WHEN s.rating_score <= 2 THEN 1 END) * 100.0) / COUNT(*), 
        1
    ) as nps_style_score
FROM survey_responses s
-- This JOIN connects survey data with user demographics
LEFT JOIN user_demographics d ON s.user_id = d.user_id  
GROUP BY d.age_group, d.subscription_type, s.question_id
-- Only show results with meaningful sample sizes
HAVING COUNT(s.response_id) >= 3  
ORDER BY avg_satisfaction DESC;

-- Business Insight: This analysis helps identify which user segments are most/least satisfied
-- Premium users vs free users might have very different satisfaction patterns
-- Different age groups might prefer different features
