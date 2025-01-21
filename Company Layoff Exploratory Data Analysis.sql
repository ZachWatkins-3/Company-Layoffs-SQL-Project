select * From layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
From layoffs_staging2;

select *
From layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions DESC;

select company, sum(total_laid_off)
From layoffs_staging2
Group by company
order by 2 desc;

select MIN(`date`), Max(`date`)
From layoffs_staging2;

select industry, sum(total_laid_off)
From layoffs_staging2
Group by industry;

select country, sum(total_laid_off)
From layoffs_staging2
Group by country
order by 2 desc;

select year (`date`), sum(total_laid_off)
From layoffs_staging2
Group by year (`date`)
order by 1 desc;

select substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging2
Where substring(`date`,1,7) IS NOT NULL
Group by `MONTH` 
Order by 1 ASC;

With Rolling_Total AS
(
select substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS Total_Off
From layoffs_staging2
Where substring(`date`,1,7) IS NOT NULL
Group by `MONTH` 
Order by 1 ASC
)
select `MONTH`, Total_Off
,sum(Total_Off) Over(order by `MONTH`) AS Rolling_Total
From Rolling_Total;

select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, YEAR(`date`)
Order by 3 DESC;

With Company_Year (company, years, total_laid_off) AS
(
select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, YEAR(`date`)
), Company_Year_Rank AS
(select *, dense_rank() over (partition by years Order by total_laid_off DESC) AS Ranking
from Company_Year
Where years IS NOT NULL)
Select * From Company_Year_Rank
Where Ranking <= 5;

With Industry_Year (Industry, years, total_laid_off) AS
(
select Industry, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by Industry, YEAR(`date`)
), Industry_Year_Rank AS
(select *, dense_rank() over (partition by years Order by total_laid_off DESC) AS Ranking
from Industry_Year
Where years IS NOT NULL)
Select * From Industry_Year_Rank
Where Ranking <= 5;

With Location_Year (location, years, total_laid_off) AS
(
select location, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by location, YEAR(`date`)
), Location_Year_Rank AS
(select *, dense_rank() over (partition by years Order by total_laid_off DESC) AS Ranking
from Location_Year
Where years IS NOT NULL)
Select * From Location_Year_Rank
Where Ranking <= 5;
