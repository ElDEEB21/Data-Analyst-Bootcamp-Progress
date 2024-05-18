-- Exploratory Data Analysis

-- Inspect all data
select * from layoffs_staging2;

-- High funding with 100% layoffs
select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- Total layoffs per company
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- Date range
select min(`date`), max(`date`)
from layoffs_staging2;

-- Total layoffs per country
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

-- Inspect all data
select * from layoffs_staging2;

-- Total layoffs per year
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 2 desc;

-- Total layoffs per stage
select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

-- Average percentage laid off per company
select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- Total layoffs per month
select substring(`date`,1,7) as `Month`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`;

-- Rolling total layoffs per month
with Rolling_Total as (
	select substring(`date`,1,7) as `Month`,sum(total_laid_off) as total_off
	from layoffs_staging2
	where substring(`date`,1,7) is not null
	group by `Month`
)
select `Month`, total_off, sum(total_off) over(order by `Month`) as rolling_total
from Rolling_Total;

-- Total layoffs per company
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- Total layoffs per company per year
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

-- Top 5 companies with most layoffs per year
with Company_Year as (
	select company, year(`date`), sum(total_laid_off)
	from layoffs_staging2
	group by company, year(`date`)
), 
Company_Year_Rank as (
	select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
	from Company_Year
	where years is not null
)
select *
from Company_Year_Rank
where Ranking <= 5;
