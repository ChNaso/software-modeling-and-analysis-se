CREATE DATABASE AppleMusicDW;
GO

USE AppleMusicDW;
GO

CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    MonthName NVARCHAR(20) NOT NULL,
    DayOfWeek INT NOT NULL,
    DayName NVARCHAR(20) NOT NULL,
    IsWeekend BIT NOT NULL
);
GO

CREATE TABLE Dim_User (
    UserKey INT IDENTITY(1,1) PRIMARY KEY,
    UserOriginalID INT NOT NULL,     
    Username NVARCHAR(50),
    CountryCode CHAR(2),
    SubscriptionPlan NVARCHAR(20),
    CurrentFlag BIT DEFAULT 1
);
GO

CREATE TABLE Dim_Song (
    SongKey INT IDENTITY(1,1) PRIMARY KEY,
    SongOriginalID INT NOT NULL,
    Title NVARCHAR(150),
    ArtistName NVARCHAR(100),
    AlbumTitle NVARCHAR(150),
    Genre NVARCHAR(50),
    DurationSeconds INT,
    ISRC CHAR(12)
);
GO

CREATE TABLE Dim_Device (
    DeviceKey INT IDENTITY(1,1) PRIMARY KEY,
    DeviceType NVARCHAR(50) -- 'iPhone', 'Android', 'Web', 'Mac'
);
GO

CREATE TABLE Fact_Stream (
    FactID BIGINT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,            -- FK към Dim_Date
    UserKey INT NOT NULL,            -- FK към Dim_User
    SongKey INT NOT NULL,            -- FK към Dim_Song
    DeviceKey INT NOT NULL,          -- FK към Dim_Device
    
    DurationListened INT NOT NULL,   
    IsFullPlay BIT DEFAULT 0,     
    StreamCount INT DEFAULT 1,  

    -- Foreign Keys
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
    FOREIGN KEY (UserKey) REFERENCES Dim_User(UserKey),
    FOREIGN KEY (SongKey) REFERENCES Dim_Song(SongKey),
    FOREIGN KEY (DeviceKey) REFERENCES Dim_Device(DeviceKey)
);
GO