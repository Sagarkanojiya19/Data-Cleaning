-- Exploratory Data Analysis

select * 
from layoffs_staging2;

select Max(total_laid_off),MAX(percentage_laid_off)
from layoffs_staging2;

select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 Desc;

select MIN(`date`),max(`date`)
from layoffs_staging2;

select industry,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 Desc;


select year(`date`),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 Desc;

select stage,sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 Desc;

select substring(`date`,1,7) As `Month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc;



with Rolling_Total As
(
select substring(`date`,1,7) As `Month`, sum(total_laid_off) as Total_offs
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
)
select `Month`,
Total_offs, sum(Total_offs) over(order by `Month`) as rolling_total
from Rolling_Total
;

select company,Year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;




With company_year (company,years,Total_offs)as
(
select company,Year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), company_year_rank as
(
select *, Dense_rank() over(partition by years order by Total_offs desc) as Ranking
from company_year
where years is not null
)
select * 
from company_year_rank
where Ranking <= 5;

