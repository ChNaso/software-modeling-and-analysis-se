USE AppleMusicDB;
GO

INSERT INTO Artists (Name, Bio, FoundedYear) VALUES 
('The Weeknd', 'Canadian singer, songwriter, and record producer.', 2010),
('Taylor Swift', 'American singer-songwriter.', 2004),
('Arctic Monkeys', 'English rock band formed in Sheffield.', 2002);

INSERT INTO Albums (Title, ReleaseDate, ArtistID, Genre) VALUES
('After Hours', '2020-03-20', 1, 'R&B'),
('1989', '2014-10-27', 2, 'Pop'),
('AM', '2013-09-09', 3, 'Indie Rock');

INSERT INTO Songs (Title, DurationSeconds, AlbumID, TrackNumber, ISRC) VALUES
('Blinding Lights', 200, 1, 1, 'USUM71917907'),
('Save Your Tears', 215, 1, 2, 'USUM72001234'),
('Shake It Off', 219, 2, 1, 'USBIG1400001'),
('Blank Space', 231, 2, 2, 'USBIG1400002'),
('Do I Wanna Know?', 272, 3, 1, 'GBBKS1300142');

INSERT INTO Users (Username, Email, CountryCode) VALUES
('music_fan_BG', 'ivan@mail.bg', 'BG'),
('john_doe_usa', 'john@gmail.com', 'US');

INSERT INTO Subscriptions (UserID, PlanType, StartDate, IsActive) VALUES
(1, 'Individual', '2023-01-01', 1),
(2, 'Family', '2023-05-15', 1);

INSERT INTO Playlists (UserID, Title, IsPublic) VALUES
(1, 'My Favorites', 1);

INSERT INTO PlaylistSongs (PlaylistID, SongID, TrackOrder) VALUES
(1, 1, 1), 
(1, 3, 2);

EXEC dbo.sp_RegisterStream 1, 1, 'iPhone 14', 200;
GO