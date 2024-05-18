-- Select all records from the 'layoffs' table
select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Handle NULL values or blank values
-- 4. Remove any unnecessary Columns

-- Create a staging table similar to the 'layoffs' table
create table layoffs_staging
like layoffs;

-- Verify the structure of the new staging table
select * 
from layoffs_staging;

-- Insert all data from the 'layoffs' table into the 'layoffs_staging' table
insert into layoffs_staging
select *
from layoffs;

-- Cleaning data: Assign a row number to each record, partitioned by key columns
select *,
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
from layoffs_staging;

-- Common Table Expression (CTE) to identify duplicates by assigning row numbers
with Duplicate_CTE as (
select *,
row_number() over(partition by company, location,
industry, total_laid_off, percentage_laid_off,
'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
-- Select duplicates (row numbers greater than 1)
select *
from Duplicate_CTE
where row_num > 1;

-- Verify records for a specific company
select *
from layoffs_staging
where company = 'Casper';

-- Create another staging table with specified columns
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

-- Select records with duplicates from the new staging table
select *
from layoffs_staging2
where row_num > 1;

-- Insert data into the new staging table with row numbers assigned for duplicates
insert into layoffs_staging2
select *,
row_number() over(partition by company, location,
industry, total_laid_off, percentage_laid_off,
'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

-- Delete duplicate records based on the row number
delete
from layoffs_staging2
where row_num > 1;

-- Verify data in the new staging table after deletion
select *
from layoffs_staging2;

-- Standardize the Data

-- Trim whitespace from the 'company' field
select company, trim(company)
from layoffs_staging2;

-- Update the 'company' field to remove leading and trailing spaces
update layoffs_staging2
set company = trim(company);

-- Verify industry records starting with 'Crypto'
select *
from layoffs_staging2
where industry like 'Crypto%';

-- Standardize the 'industry' field for 'Crypto'
update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

-- Select distinct 'country' records, trimming trailing periods
select distinct country, trim(trailing '.' from country)
from layoffs_staging2;

-- Update 'country' field to remove trailing periods for 'United States'
update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- Convert 'date' field from text to Date format
select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

-- Update the 'date' field to the new Date format
update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

-- Modify the column type for 'date' to Date
alter table layoffs_staging2
modify column `date` Date;

-- Handle NULL values or blank values

-- Select records where both 'total_laid_off' and 'percentage_laid_off' are NULL
select *
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

-- Update 'industry' field to NULL where it is blank
update layoffs_staging2
set industry = null
where industry = '';

-- Select records where 'industry' is NULL or blank
select *
from layoffs_staging2
where industry is null or industry = '';

-- Verify records for companies starting with 'bally'
select *
from layoffs_staging2
where company like 'bally%';

-- Join the table to find and update 'industry' for NULL or blank values
select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
    on t1.company = t2.company and t1.location = t2.location
where (t1.industry is null or t1.industry = '') and t2.industry is not null;

-- Update 'industry' field where it is NULL or blank based on join condition
update layoffs_staging2 as t1
join layoffs_staging2 as t2
    on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

-- Select records where both 'total_laid_off' and 'percentage_laid_off' are NULL
select *
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

-- Delete records where both 'total_laid_off' and 'percentage_laid_off' are NULL
delete 
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

-- Verify the final data in the new staging table
select *
from layoffs_staging2;

-- Remove any unnecessary Columns

-- Drop the 'row_num' column from the table
alter table layoffs_staging2
drop column row_num;
