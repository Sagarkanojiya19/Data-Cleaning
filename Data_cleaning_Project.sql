-- Data Cleaning

select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standadize The data
-- 3. NULL values or blank values
-- 4. Remove Any Columns


Create Table layoffs_staging
like layoffs;

select *
from layoffs_staging;

Insert layoffs_staging
select *
from layoffs;

select * 
from layoffs_staging;

select * ,
Row_number() over(
partition by company , industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

with duplicate_cte as
(
select * ,
Row_number() over(
partition by company , location,
 industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;


select *
from layoffs_staging
where company = 'Casper';

with duplicate_cte as
(
select * ,
Row_number() over(
partition by company , location,
 industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) as row_num
from layoffs_staging
)
Delete
from duplicate_cte
where row_num > 1;

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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging2;

Insert  layoffs_staging2
select * ,
Row_number() over(
partition by company , location,
 industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) as row_num
from layoffs_staging;

delete 
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;


