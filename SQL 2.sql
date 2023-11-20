--Cleaning data in SQL Querise

Select *
From SQLportfolioproject..Nashvillehousing


--Standardize Data Fromet 

Select saleDateConverted, CONVERT(Date,SaleDate)
From SQLportfolioproject..Nashvillehousing


Update Nashvillehousing 
SET SaleDate = CONVERT(Date,saleDate)


ALTER TABLE Nashvillehousing
ADD SaleDataConverted Data;

Update Nashvillehousing
SET  SaleDataConverted = CONVERT(Date,SaleDate)


--Populate Property Address Data


Select *
From SQLportfolioproject..Nashvillehousing
--where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.propertyAddress, b.ParcelID, b.propertyAddress, ISNULL(a.propertyAddress,b.propertyAddress)
From SQLportfolioproject..Nashvillehousing a
JOIN SQLportfolioproject..Nashvillehousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

Update a
SET propertyAddress = ISNULL(a.propertyAddress,b.propertyAddress)
From SQLportfolioproject..Nashvillehousing a
JOIN SQLportfolioproject..Nashvillehousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


--Brekoing out address into individul Columns (address,city ,stats)

Select propertyAddress
From SQLportfolioproject..Nashvillehousing
--where PropertyAddress is null
--order by ParcelID

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1 ),LEN(',',PropertyAddress)) as Address

From SQLportfolioproject..Nashvillehousing

ALTER TABLE Nashvillehousing
ADD PropertySplitAddress Nvarchar(255);

Update Nashvillehousing
SET  PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE Nashvillehousing
ADD PropertySplitCity Nvarchar(255);

Update Nashvillehousing
SET  PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1 ),LEN(',',PropertyAddress))



Select *
From SQLportfolioproject..Nashvillehousing



Select OwnerAddress
From SQLportfolioproject..Nashvillehousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', ','),3)
,PARSENAME(REPLACE(OwnerAddress, ',', ','),2)
,PARSENAME(REPLACE(OwnerAddress, ',', ','),1)
From SQLportfolioproject..Nashvillehousing


ALTER TABLE Nashvillehousing
ADD OwnerSplitAddress Nvarchar(255);

Update Nashvillehousing
SET  OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', ','),3)  

ALTER TABLE Nashvillehousing
ADD OwnerSplitCity Nvarchar(255);

Update Nashvillehousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', ','),2)

ALTER TABLE Nashvillehousing
ADD OwnerSplitState Nvarchar(255);

Update Nashvillehousing
SET  OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', ','),1)



Select *
From SQLportfolioproject..Nashvillehousing


--Change Y and N to yes and NO in "sold as  vacatnt" field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From SQLportfolioproject..Nashvillehousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
,CASE When SoldAsVacant = 'Y' THEN 'Yes'
      When SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant
	  END
From SQLportfolioproject..Nashvillehousing

Update Nashvillehousing
SET SoldAsVacant = CASE  When SoldAsVacant = 'Y' THEN 'Yes'
      When SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant
	  END


--- Remove Duplicates


Select * ,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
		         PropertyAddress,
				 SalePrice,
				 LegalReference
				 ORDER BY
				   UniqueID 
				   ) row_num
				     
From SQLportfolioproject..Nashvillehousing



Select *
From SQLportfolioproject..Nashvillehousing