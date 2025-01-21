Insert layoffs_staging
Select *
From layoffs_raw;

Select *,
Row_number() Over (
partition by company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
From layoffs_staging;

With duplicate_cte AS
(Select *,
Row_number() Over (
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
From layoffs_staging)
Select * 
From duplicate_cte
Where row_num > 1;

Select *
from layoffs_staging
where company = 'Casper' ;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

Insert into layoffs_staging2
Select *,
Row_number() Over (
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
From layoffs_staging ;

Select *
from layoffs_staging2;

Select distinct trim(company)
From layoffs_staging2 ;

UPDATE layoffs_staging2
SET company = trim(company);

Select *
From layoffs_staging2
where industry Like 'Crypto%' ;

Update layoffs_staging2
Set industry = 'Crypto'
Where industry like 'Crypto%' ;

select distinct industry
From layoffs_staging2 ;

select distinct country
From layoffs_staging2 
Order by 1;

Select distinct country, trim(Trailing '.' From country)
From layoffs_staging2
Order by 1;

Update layoffs_staging2
Set country = trim(Trailing '.' From country)
Where country Like 'United States%' ;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2 ;

Update layoffs_staging2
Set `date` = str_to_date(`date`, '%m/%d/%Y') ;

Select `date`
From layoffs_staging2;

Alter table layoffs_staging2
modify column `date` DATE;

select * 
from layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

select *
from layoffs_staging2 
Where industry IS NULL
Or industry = '';

Select *
From layoffs_staging2
Where company = 'Airbnb' ; 

Update layoffs_staging2
Set industry = null
Where industry = '' ;

select *
From layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
Where (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL ; 

Update layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
set t1.industry = t2.industry
Where t1.industry IS NULL
AND t2.industry IS NOT NULL ; 

Select *
From layoffs_staging2
Where company Like 'Bally%' ;

select * 
from layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

Delete
from layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

select *
from layoffs_staging2 ;

Alter table layoffs_staging2
Drop column row_num ;