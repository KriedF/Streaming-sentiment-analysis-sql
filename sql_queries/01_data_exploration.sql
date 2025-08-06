-- Basic Satisfaction Analysis for Streaming Platform Features
-- This query shows overall satisfaction rates by feature type
-- Business Question: Which features are performing best/worst?

SELECT 
    question_id as feature_name,
    COUNT(*) as total_responses,
    ROUND(AVG(rating_score), 2) as average_rating,
    MIN(rating_score) as lowest_rating,
    MAX(rating_score) as highest_rating,
    -- Calculate satisfaction percentage (ratings 4-5 out of 5)
    ROUND(
        (COUNT(CASE WHEN rating_score >= 4 THEN 1 END) * 100.0) / COUNT(*), 
        1
    ) as satisfaction_percentage
FROM survey_responses 
GROUP BY question_id
ORDER BY satisfaction_percentage DESC;

-- Business Insight: This helps product managers prioritize which features need improvement
-- Features with low satisfaction_percentage should be investigated first
