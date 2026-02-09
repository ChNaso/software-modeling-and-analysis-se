USE AppleMusicDB;
GO

CREATE FUNCTION dbo.fn_GetAlbumDuration (@AlbumID INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @TotalSeconds INT;
    DECLARE @Result NVARCHAR(20);

    SELECT @TotalSeconds = SUM(DurationSeconds)
    FROM Songs
    WHERE AlbumID = @AlbumID;

    IF @TotalSeconds IS NULL SET @TotalSeconds = 0;

    SET @Result = CAST(@TotalSeconds / 60 AS NVARCHAR(10)) + ':' + 
                  RIGHT('0' + CAST(@TotalSeconds % 60 AS NVARCHAR(2)), 2);

    RETURN @Result;
END;
GO

CREATE PROCEDURE dbo.sp_RegisterStream
    @UserID INT,
    @SongID INT,
    @DeviceType NVARCHAR(50),
    @SecondsListened INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO StreamHistory (UserID, SongID, StreamDate, DeviceType, DurationListened)
        VALUES (@UserID, @SongID, GETDATE(), @DeviceType, @SecondsListened);

        IF @SecondsListened >= 30
        BEGIN
            UPDATE Songs
            SET PlayCount = PlayCount + 1
            WHERE SongID = @SongID;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE TRIGGER trg_UpdatePlaylistTimestamp
ON PlaylistSongs
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @PlaylistID INT;

    SELECT TOP 1 @PlaylistID = COALESCE(i.PlaylistID, d.PlaylistID)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.PlaylistID = d.PlaylistID;

    UPDATE Playlists
    SET LastModified = GETDATE()
    WHERE PlaylistID = @PlaylistID;
END;
GO