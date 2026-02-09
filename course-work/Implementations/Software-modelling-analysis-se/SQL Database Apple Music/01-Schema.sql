CREATE DATABASE AppleMusicDB;
GO

USE AppleMusicDB;
GO

CREATE TABLE Artists (
    ArtistID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Bio NVARCHAR(MAX),
    FoundedYear INT
);
GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    CountryCode CHAR(2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Subscriptions (
    SubscriptionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    PlanType NVARCHAR(20) CHECK (PlanType IN ('Individual', 'Family', 'Student')),
    StartDate DATE NOT NULL,
    EndDate DATE,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE Albums (
    AlbumID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    ReleaseDate DATE NOT NULL,
    ArtistID INT NOT NULL,
    Genre NVARCHAR(50),
    CoverImageUrl NVARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);
GO

CREATE TABLE Songs (
    SongID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    DurationSeconds INT NOT NULL,
    AlbumID INT NOT NULL,
    TrackNumber INT,
    ISRC CHAR(12) UNIQUE,
    PlayCount BIGINT DEFAULT 0,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);
GO

CREATE TABLE Playlists (
    PlaylistID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    IsPublic BIT DEFAULT 0,
    LastModified DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE PlaylistSongs (
    PlaylistID INT NOT NULL,
    SongID INT NOT NULL,
    AddedAt DATETIME DEFAULT GETDATE(),
    TrackOrder INT NOT NULL,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);
GO

CREATE TABLE StreamHistory (
    StreamID BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    SongID INT NOT NULL,
    StreamDate DATETIME DEFAULT GETDATE(),
    DeviceType NVARCHAR(50),
    DurationListened INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);
GO