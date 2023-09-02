--Skills used joins, cte's, temp tables, windows functions, aggregate functions, creating views, converting data types

Select * from CovidDeaths$
where continent is not null
order by 3,4

--select data we are starting with

select location, date, total_cases, new_cases,
total_deaths, population
from CovidDeaths$
where continent is not null
order by 1,2

--Total cases vs Total deaths
--shows likelihood of dying if you contract covid in USA

select location, date, total_cases, total_deaths,
(total_deaths/Total_cases)*100 as DeathPercentange
from CovidDeaths$
where Location like '%states%'
and continent is not null
order by 1,2

--Total cases VS Population
--Shows what percentage of population became infected with covid

select location, date, population, total_cases, 
(total_cases/Population)*100 as percentpopulationinfected
from CovidDeaths$
where continent is not null
order by 1,2

--Looking at countries with highest infection rate compared to population

select location, population, Max(total_cases) as highestInfectionCount, 
Max((total_cases/Population))*100 as percentpopulationinfected
from CovidDeaths$
where continent is not null
group by location, population
order by percentpopulationinfected desc

--Countries with the highest death count per population 
--change varchar to int

Select location, max(cast(total_deaths as int)) as totaldeathcount
from CovidDeaths$
where continent is not null
group by location 
order by totaldeathcount desc

--Continents with the highest death count per population

Select continent, max(cast(total_deaths as int)) as totaldeathcount
from CovidDeaths$
where continent is not null
group by continent
order by totaldeathcount desc

--global numbers
--change varchar to int

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from CovidDeaths$
where continent is not null
order by 1,2

--by date
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from CovidDeaths$
where continent is not null
group by date
order by 1,2

--total population vs vaccinations - Joins and alliases 
--shows percent of population that has recieved at least one covid vaccine.

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths$ as dea
join CovidVaccinations$ as vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
order by 1,2,3
