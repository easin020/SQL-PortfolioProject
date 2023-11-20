Select *
From SQLproject..CovidDeaths$
where continent is not null
order by 3,4

--Select *
--From SQLproject..CovidVaccinations$
--order by 3,4
--Select Data that we are going to be using


Select Location, date, total_cases, new_cases, total_deaths, population
From SQLproject..CovidDeaths$
where continent is not null
order by 1,2

--Looking at Total Cases vs Total Deaths
--Show likelihood of dying if you contract covid in your contry 

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathPercentage
From SQLproject..CovidDeaths$
where location like '%states%'
and continent is not null
order by 1,2

--looking at total cases vs population
--show what precentage of population got Covid

Select Location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From SQLproject..CovidDeaths$
--where location like '%states%'
order by 1,2


--looking at Countries with highest Infection Reat compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as  PercentPopulationInfected
From SQLproject..CovidDeaths$
--where location like '%states%'
Group by Location,  population
order by  PercentPopulationInfected desc

--showing Countries with highest death per Population

Select Location, MAX(cast (Total_deaths as int)) as TotalDeathCount
From SQLproject..CovidDeaths$
--where location like '%states%'
where continent is not null
Group by Location
order by  TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, MAX(cast (Total_deaths as int)) as TotalDeathCount
From SQLproject..CovidDeaths$
--where location like '%states%'
where continent is not null
Group by continent
order by  TotalDeathCount desc

--showing continents with highest death count per population

Select continent, MAX(cast (Total_deaths as int)) as TotalDeathCount
From SQLproject..CovidDeaths$
--where location like '%states%'
where continent is not null
Group by continent
order by  TotalDeathCount desc

--GLOBAL NUMBER 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) *100 as deathPercentage
From SQLproject..CovidDeaths$
--where location like '%states%'
where continent is not null
--Group by date
order by 1,2


Select *
From SQLproject..CovidVaccinations$