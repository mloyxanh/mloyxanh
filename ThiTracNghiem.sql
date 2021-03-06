USE [TN_CSDLPT]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_CT_BAITHI]    Script Date: 4/24/2022 10:06:16 AM ******/
CREATE TYPE [dbo].[TYPE_CT_BAITHI] AS TABLE(
	[MASV] [nchar](8) NULL,
	[MAMH] [nchar](5) NULL,
	[LAN] [smallint] NULL,
	[MACH] [int] NULL,
	[DAP_AN_CHON] [nchar](1) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[Check_Lop_MH_Da_Thi]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Check_Lop_MH_Da_Thi] 
(	
	@MAMH nchar(5),
	@MALOP nchar(15),
	@LAN smallint
)
RETURNS nchar(1) 
AS
BEGIN 
	DECLARE @checked nchar(1);

	IF EXISTS(SELECT bdl.MASV 
	FROM
		(SELECT sv.MASV FROM SINHVIEN sv
		 WHERE (sv.MALOP = @MALOP)) lsv
		INNER JOIN
		(SELECT bd.MASV 
		 FROM  BANGDIEM bd
		 WHERE (bd.MAMH = @MAMH AND bd.LAN = @LAN )) bdl 
	   On lsv.MASV = bdl.MASV) 
	  SET @checked = 'X'
	ELSE SET @checked = ''
	RETURN @checked
END
GO
/****** Object:  View [dbo].[Get_Subscribes]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_Subscribes]
AS
SELECT PUBS.description AS TENCS, SUBS.subscriber_server AS TENSERVER
FROM   dbo.sysmergepublications AS PUBS INNER JOIN
          dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server
WHERE  (PUBS.description <> N'TRA CUU')
GO
/****** Object:  Table [dbo].[BANGDIEM]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGDIEM](
	[MASV] [char](8) NOT NULL,
	[MAMH] [char](5) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[NGAYTHI] [datetime] NULL,
	[DIEM] [float] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_BANGDIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BODE]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BODE](
	[CAUHOI] [int] NOT NULL,
	[MAMH] [char](5) NULL,
	[TRINHDO] [char](1) NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [char](1) NULL,
	[MAGV] [char](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_BODE] PRIMARY KEY CLUSTERED 
(
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COSO]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSO](
	[MACS] [nchar](3) NOT NULL,
	[TENCS] [nvarchar](50) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_COSO] PRIMARY KEY CLUSTERED 
(
	[MACS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_BAITHI]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_BAITHI](
	[MAMH] [char](5) NOT NULL,
	[MASV] [char](8) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[MACH] [int] NOT NULL,
	[DAP_AN_CHON] [nchar](1) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_CT_BAITHI] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MASV] ASC,
	[LAN] ASC,
	[MACH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAGV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MAKH] [nchar](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOVIEN_DANGKY]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DANGKY](
	[MAGV] [char](8) NULL,
	[MAMH] [char](5) NOT NULL,
	[MALOP] [nchar](15) NOT NULL,
	[TRINHDO] [char](1) NULL,
	[NGAYTHI] [datetime] NULL,
	[LAN] [smallint] NOT NULL,
	[SOCAUTHI] [smallint] NULL,
	[THOIGIAN] [smallint] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_GIAOVIEN_DANGKY] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MALOP] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [nchar](8) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[MACS] [nchar](3) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOP]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [nchar](15) NOT NULL,
	[TENLOP] [nvarchar](50) NOT NULL,
	[MAKH] [nchar](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UN_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [char](5) NOT NULL,
	[TENMH] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_TENMH] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UN_TENMH] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 4/24/2022 10:06:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[NGAYSINH] [date] NULL,
	[DIACHI] [nvarchar](100) NULL,
	[MALOP] [nchar](15) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PASSWORD] [nchar](60) NULL,
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BANGDIEM] ADD  CONSTRAINT [MSmerge_df_rowguid_8F1696CE8CFA49B39A69275323591CB1]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[BODE] ADD  CONSTRAINT [MSmerge_df_rowguid_788A62D414DE41E5A513198A2969A74F]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[COSO] ADD  CONSTRAINT [MSmerge_df_rowguid_1720058E58C9486282F6053FD1B210A2]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[CT_BAITHI] ADD  CONSTRAINT [MSmerge_df_rowguid_3750603CDB004014A5BC6EB37C703D27]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[GIAOVIEN] ADD  CONSTRAINT [MSmerge_df_rowguid_8B88B967A33A4F3B850E17159D026870]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] ADD  CONSTRAINT [MSmerge_df_rowguid_9367382900E34234ABB6B939CC93EA70]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[KHOA] ADD  CONSTRAINT [MSmerge_df_rowguid_061B773264E844249B17AA3C1CF85A01]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [MSmerge_df_rowguid_0584757E64C14FEDBC2D0A443ACDA345]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [MSmerge_df_rowguid_DB969659092947C6AB2FFEE49FA0FDA9]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[SINHVIEN] ADD  CONSTRAINT [MSmerge_df_rowguid_1DF414D3774F448C80BACD0E31A0481C]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_MONHOC]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_SINHVIEN1] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_SINHVIEN1]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_GIAOVIEN] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_GIAOVIEN]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_MONHOC]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_BAITHI_BODE] FOREIGN KEY([MACH])
REFERENCES [dbo].[BODE] ([CAUHOI])
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_CT_BAITHI_BODE]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_BAITHI_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_CT_BAITHI_MONHOC]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_BAITHI_SINHVIEN] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_CT_BAITHI_SINHVIEN]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_KHOA]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1]
GO
ALTER TABLE [dbo].[KHOA]  WITH CHECK ADD  CONSTRAINT [FK_KHOA_COSO] FOREIGN KEY([MACS])
REFERENCES [dbo].[COSO] ([MACS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHOA] CHECK CONSTRAINT [FK_KHOA_COSO]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_DIEM]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_LANTHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_LANTHI]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_BODE] CHECK  (([TRINHDO]='A' OR [TRINHDO]='B' OR [TRINHDO]='C'))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_BODE]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN] CHECK  (([DAP_AN]='D' OR ([DAP_AN]='C' OR ([DAP_AN]='B' OR [DAP_AN]='A'))))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_DAPAN]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN_CHON] CHECK  (([DAP_AN_CHON]='D' OR ([DAP_AN_CHON]='C' OR ([DAP_AN_CHON]='B' OR ([DAP_AN_CHON]='A' OR [DAP_AN_CHON] IS NULL)))))
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [CK_DAPAN_CHON]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [CK_LAN_BAITHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [CK_LAN_BAITHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_LAN] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_LAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_SOCAUTHI] CHECK  (([SOCAUTHI]>=(10) AND [SOCAUTHI]<=(100)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_SOCAUTHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_THOIGIAN] CHECK  (([THOIGIAN]>=(15) AND [THOIGIAN]<=(60)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_THOIGIAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_TRINHDO] CHECK  (([TRINHDO]='C' OR ([TRINHDO]='B' OR [TRINHDO]='A')))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_TRINHDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_BANGDIEM_MONHOC]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_BANGDIEM_MONHOC] 
	@MALOP char(15),
	@MAMH char(5),
	@LAN smallint
AS
BEGIN
	SELECT bd.MASV, HO, TEN, DIEM FROM (
	(SELECT  DIEM, MASV FROM BANGDIEM WHERE MAMH = @MAMH AND LAN = @LAN) bd
	INNER JOIN 
	(SELECT MASV, HO, TEN FROM SINHVIEN WHERE MALOP = @MALOP) sv
	ON sv.MASV = bd.MASV
)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CauHoi]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_CauHoi]
	@maMH nchar(5), @trinhDo nchar(1), @soCauThi int
AS
BEGIN
	DECLARE @countCauHoi int, @countCauHoiSiteKhac int, @TrinhDoDuoi nchar(1),
	 @countCauHoiDuoi int, @countCHDuoiSiteKhac int
	
	--Trình độ A
	IF(@trinhDo = 'A')
	BEGIN 
		SET @TrinhDoDuoi = 'B'
	END
	--Trình độ B
	ELSE IF(@trinhDo = 'B')
	BEGIN 
		SET @TrinhDoDuoi = 'C'
	END
	IF(@trinhDo = 'C')
	BEGIN
		-- Đếm số câu hỏi có môn học, trình độ là các tham số và thuộc giáo viên của site hiện tại
		SELECT @countCauHoi = COUNT(CAUHOI) FROM BODE 
		WHERE MAMH = 'AVCB' AND TRINHDO = 'A' AND MAGV IN 
		(SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
			
		-- Nếu số câu hỏi đó lớn hơn hoặc bằng số câu cần lấy
		IF(@countCauHoi >= @soCauThi)
		BEGIN
			-- Lấy ngẫu nhiên số câu hỏi trong bộ đề thuộc site hiện tại, , NewID() is used to generate unique identifier value
			SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
			ORDER BY  NEWID()
		END
		-- Nếu số câu hỏi đó bé hơn số câu cần lấy
		ELSE IF(@countCauHoi < @soCauThi)
		BEGIN
			-- Đếm số câu hỏi thuộc site khác
			SELECT @countCauHoiSiteKhac = COUNT(CAUHOI) FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN 
				(SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 

			IF(@countCauHoiSiteKhac < @soCauThi - @countCauHoi)
			BEGIN-- thiếu đề
				RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
			END
			ELSE IF(@countCauHoiSiteKhac >= @soCauThi - @countCauHoi)
			BEGIN
				--UNION 2 SELECT random câu hỏi của giáo viên cả 2 site
				SELECT * FROM ( 
					SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY NEWID()
				) AS SITEHT
				UNION ALL
				SELECT * FROM ( 
					SELECT TOP (@soCauThi - @countCauHoiSiteKhac) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()
				) AS SITEKHAC
			END
		END
	END
	-- Trình độ A hoặc B
	ELSE 
	BEGIN
		--Đếm số câu hỏi site hiện tại (A)
		SELECT @countCauHoi = COUNT(CAUHOI) FROM BODE 
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
		
		IF(@countCauHoi >= @soCauThi)--Nếu đủ (A>= 100%)
		BEGIN
			SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
			ORDER BY  NEWID()
		END
		ELSE IF(@countCauHoi >= @soCauThi*0.7) -- Trên 70% số câu hỏi cần thì lấy ở trình độ dưới
		BEGIN 
			SELECT @countCauHoiDuoi = COUNT(CAUHOI) FROM BODE -- Đếm số lượng câu hỏi ở trình độ dưới (B)
			WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					
			-- Nếu câu thi ở trình độ dưới đủ (B >= 100% - A)
			IF(@countCauHoiDuoi >= @soCauThi - @countCauHoi) 
				BEGIN 
					SELECT * FROM (
						SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TRINHDOTREN
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TRINHDODUOI
				END
			ELSE -- Nếu câu thi ở trình độ dưới không đủ qua cơ sở khác
			BEGIN
				-- Đếm câu hỏi cùng trình độ mà ở site khác (A2)
				SELECT @countCauHoiSiteKhac = COUNT(CAUHOI) FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						
				-- Đếm câu hỏi trình độ dưới ở site khác (B2)
				SELECT @countCHDuoiSiteKhac = COUNT(CAUHOI) FROM BODE
				WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							
				-- Nếu câu hỏi cùng trình độ site khác đủ ( A2 >=  100% - A - B)
				IF(@countCauHoiSiteKhac >= @soCauThi - @countCauHoi - @countCauHoiDuoi )
				BEGIN
					SELECT * FROM (
						SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TRINHDOTREN
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TRINHDODUOI
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TRINHDOSITEKHAC
				END
				-- Nếu mà câu hỏi cùng trình độ site khác mà không đủ thì lấy câu hỏi trình độ dưới site khác(B2 >= 100 -A - A2 - B)
				ELSE IF(@countCauHoiSiteKhac >= @soCauThi - @countCauHoi - @countCauHoiSiteKhac - @countCauHoiDuoi)
				BEGIN
					SELECT * FROM (
						SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoTren
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoDuoi
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoSiteKhac
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoDuoiSiteKhac
				END 
				-- Nếu không đủ
				ELSE 
				BEGIN-- thiếu đề
					RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
				END
			END
		END
		-- Nếu mà số câu hỏi cùng trình độ mà không đủ 70% thì qua site khác lấy
		ELSE 
		BEGIN 
			-- Đếm câu hỏi cùng trình độ mà ở site khác (A2)
			SELECT @countCauHoiSiteKhac = COUNT(CAUHOI) FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
			
			-- Nếu câu hỏi site khác cùng trình độ đủ
			IF(@countCauHoiSiteKhac >= @soCauThi - @countCauHoi)
			BEGIN 
				SELECT * FROM (
					SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()
				) AS CauHoiCungSite
				UNION ALL
				SELECT * FROM (
					SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()
				) AS CungTrinhDoSiteKhac
			END	
			-- Nếu mà câu hỏi cùng trình độ site khác và câu hỏi cùng trình độ site hiện tại 
			-- tổng lớn hơn 70% thì 30% còn lại lấy câu hỏi trình độ dưới (A2 + A >= 70%)
			ELSE IF(@countCauHoiSiteKhac >= @soCauThi*0.7 - @countCauHoi) 
			BEGIN
				SELECT @countCauHoiDuoi = COUNT(CAUHOI) FROM BODE -- B
				WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						
				SELECT @countCHDuoiSiteKhac = COUNT(CAUHOI) FROM BODE -- B2
				WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					
				-- Lấy câu hỏi trình độ dưới cùng site 
				IF(@countCauHoiDuoi>= @soCauThi - @countCauHoi - @countCauHoiSiteKhac ) 
					BEGIN
						SELECT * FROM (
						SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDo
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS CungTrinhDoSiteKhac
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoDuoi
				END
				-- Lấy câu hỏi trình độ dưới khác site thêm vào( B2 >= 100 -A - A2 - B)
				ELSE IF(@countCHDuoiSiteKhac >= @soCauThi - @countCauHoi - @countCauHoiSiteKhac - @countCauHoiDuoi)
				BEGIN 
					SELECT * FROM (
						SELECT TOP (@countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDo
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS CungTrinhDoSiteKhac
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoDuoi
					UNION ALL
					SELECT * FROM (
						SELECT TOP (@soCauThi - @countCauHoi - @countCauHoiDuoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					) AS TrinhDoDuoiSiteKhac
				END
				ELSE -- thiếu đề
				BEGIN
					RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
				END
			END
			ELSE -- thiếu đề
			BEGIN
				RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
			END
				
		END
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CT_BAITHI]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_CT_BAITHI] 
	@MASV char(8),
	@MAMH char(5),
	@LAN smallint
AS
BEGIN
	select CH.CAUHOI, A, B, C, D, DAP_AN, NOIDUNG, DAP_AN_CHON from (SELECT CAUHOI, A, B, C, D, DAP_AN, NOIDUNG FROM BODE
		WHERE MAMH = @MAMH) CH INNER JOIN 
	(SELECT MACH, DAP_AN_CHON FROM CT_BAITHI WHERE MASV = @MASV AND MAMH = @MAMH AND  LAN = @LAN) CT
	ON CH.CAUHOI = CT.MACH
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DS_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_DS_GVDK] 
	@FROM DATETIME,
	@TO DATETIME
AS
	
BEGIN
	SELECT TENLOP = (SELECT TENLOP FROM LOP WHERE gvdk.MALOP = MALOP), 
		   TENMH = (SELECT TENMH FROM MONHOC WHERE gvdk.MAMH = MAMH), 
		   HOTEN = (SELECT HO + ' ' + TEN FROM GIAOVIEN WHERE gvdk.MAGV = MAGV), 
		   SOCAUTHI, NGAYTHI, dbo.Check_Lop_MH_Da_Thi(gvdk.MAMH, gvdk.MALOP, gvdk.LAN) AS DATHI 
	FROM GIAOVIEN_DANGKY as gvdk WHERE NGAYTHI BETWEEN @FROM AND @TO 
	ORDER BY NGAYTHI ASC
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_GV_CHUA_DK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_GV_CHUA_DK]
AS
BEGIN
	-- Lấy id user của role (TRUONG, COSO, GIANGVIEN)
	-- Lấy id member của user (TRUONG, COSO, GIANGVIEN)
	-- Từ id member truy vấn name (là mã gv đã đăng ký))
	-- Lấy tất cả giáo viên không thuộc list magv trên
	SELECT MAGV, HO + ' ' + TEN AS HOTEN from giaovien where MAGV NOT IN (
		SELECT MAGV = (SELECT name FROM sys.sysusers WHERE uid = memberuid) FROM 
			(SELECT uid FROM sys.sysusers WHERE name = 'TRUONG' or name = 'GIANGVIEN' or name = 'COSO') listIdGroup
			INNER JOIN 
			(SELECT memberuid, groupuid FROM sys.sysmembers) listIdMember
			ON listIdGroup.uid = listIdMember.groupuid
	)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GET_GVDK]
  @MALOP nchar(15),
  @MAMH nchar(5),
  @NGAYTHI datetime,
  @LAN smallint
AS
select * from GIAOVIEN_DANGKY where MALOP = @MALOP AND MAMH = @MAMH AND NGAYTHI = @NGAYTHI AND LAN = @LAN
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_MH_DATHI_SV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_MH_DATHI_SV]
@MASV char(8)
AS
BEGIN
	SELECT DISTINCT MAMH, TENMH = (SELECT TENMH FROM MONHOC WHERE MAMH = BD.MAMH) FROM BANGDIEM AS BD WHERE MASV = @MASV
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PASSWORD_FROM_MASV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_PASSWORD_FROM_MASV]
	 @maSV nchar(8)
AS
BEGIN
	SELECT PASSWORD FROM SINHVIEN  WHERE MASV = @maSV 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_KQ_THI]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_KQ_THI]
	@BAITHI TYPE_CT_BAITHI READONLY,
	@MASV nchar(8),
	@MAMH nchar(5),
	@LAN smallint,
	@NGAYTHI datetime,
	@DIEM float
AS  
BEGIN  
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO BANGDIEM(MASV, MAMH, LAN, NGAYTHI, DIEM) VALUES(@MASV, @MAMH, @LAN, @NGAYTHI, @DIEM)

		INSERT INTO CT_BAITHI(MASV, MAMH, LAN, MACH, DAP_AN_CHON) SELECT MASV, MAMH, LAN, MACH, NULLIF(DAP_AN_CHON,'') FROM @BAITHI  
		
		COMMIT

	END TRY
	BEGIN CATCH

		 ROLLBACK
		 DECLARE @ErrorMessage VARCHAR(100)
		 SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		 RAISERROR(@ErrorMessage, 16, 1)

	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Bo_De_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_Bo_De_Ton_Tai]
  @MACH int
  
AS

IF exists(select * from dbo.BODE where CAUHOI = @MACH)
	raiserror ('Mã câu hỏi đã tồn tại, vui lòng nhập lại',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Giao_Vien_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Giao_Vien_Ton_Tai]
  @MAGV nchar(8)
AS
  
If  exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV =@MAGV)
   	raiserror ('Mã GV đã tồn tại, vui lòng chọn mã khác',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_GVDK]
  @MAMH nchar(5),
  @MALOP nchar(15),
  @LAN smallint
AS

IF exists(select * from dbo.GIAOVIEN_DANGKY where MAMH =@MAMH AND MALOP =@MALOP AND LAN = @LAN)
		SELECT '1'
ELSE SELECT '0'
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Khoa_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Khoa_Ton_Tai]
  @MAKH nchar(8),
  @TENKH nvarchar(50)
AS

BEGIN
	IF EXISTS(SELECT MAKH FROM KHOA WHERE MAKH =@MAKH)
		SELECT '1'
	ELSE IF EXISTS(SELECT TENKH FROM KHOA WHERE TENKH =@TENKH)
		SELECT '2'
	ELSE IF EXISTS(SELECT MAKH FROM LINK0.TN_CSDLPT.dbo.KHOA WHERE MAKH = @MAKH)
		SELECT '1'
	ELSE IF EXISTS(SELECT TENKH FROM LINK0.TN_CSDLPT.dbo.KHOA WHERE TENKH = @TENKH)
		SELECT '2'
	ELSE SELECT '0'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Lan_Thi]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_KT_Lan_Thi]
@MASV nchar(8), @MAMH nchar(5), @LAN smallint
AS

IF EXISTS (SELECT MASV, MAMH, LAN FROM BANGDIEM WHERE MASV = @MASV AND MAMH = @MAMH AND LAN = @LAN)
	SELECT '1'
ELSE SELECT '0'
GO
/****** Object:  StoredProcedure [dbo].[sp_KT_Lop_Da_Thi]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_KT_Lop_Da_Thi] @MALOP nchar(15), @MAMH nchar(5), @LAN smallint
as
begin
	IF EXISTS(SELECT bdl.MASV 
	From
		(Select sv.MASV From SINHVIEN sv
		 Where (sv.MALOP = @MALOP)) As lsv
	   Inner Join
		(Select bd.MASV 
		 From  BANGDIEM bd
		 Where (bd.MAMH = @MAMH AND bd.LAN = @LAN )) As bdl 
	   On lsv.MASV = bdl.MASV) 
	   SELECT '1'
	ELSE SELECT '0'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Lop_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Lop_Ton_Tai]
  @MALOP nchar(15),
  @TENLOP nvarchar(40)
AS

BEGIN
	IF exists(select MALOP from LINK1.TN_CSDLPT.dbo.LOP where MALOP = @MALOP)
		SELECT '1'
	ELSE IF exists(select TENLOP from LINK1.TN_CSDLPT.dbo.LOP where TENLOP = @TENLOP)
		SELECT '2'
	ELSE SELECT '0'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_MonHoc_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_MonHoc_Ton_Tai]
  @MAMH char(8),
  @TENMH nvarchar(40)
AS
	If  exists(SELECT MAMH FROM  MONHOC WHERE MAMH = @MAMH)
		SELECT '1'
	Else If  exists(SELECT TENMH FROM MONHOC WHERE TENMH = @TENMH)
		SELECT '2'
	Else
		SELECT '0'
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Sinh_Vien_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_Sinh_Vien_Ton_Tai]
  @MASV  nchar(8)
AS
	IF exists(SELECT MASV FROM LINK1.TN_CSDLPT.dbo.SINHVIEN WHERE MASV = @MASV)
		raiserror ('Mã Sinh Viên đã tồn tại, vui lòng chọn mã khác',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Sua_Khoa_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Sua_Khoa_Ton_Tai]
	@MAKH nchar(8),
	@TENKH nvarchar(50)

AS

BEGIN
	IF exists(select TENKH from LINK0.TN_CSDLPT.dbo.KHOA where TENKH =@TENKH AND MAKH != @MAKH)
		raiserror ('Tên khoa đã tồn tại, vui lòng đặt tên khác',16,1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Sua_Lop_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Sua_Lop_Ton_Tai]
	@MALOP nchar(15),
	@TENLOP nvarchar(40)
AS

BEGIN
	IF exists(select TENLOP from LINK1.TN_CSDLPT.dbo.LOP where TENLOP = @TENLOP AND MALOP != @MALOP)
		raiserror ('Tên lớp đã tồn tại, vui lòng đặt tên khác',16,1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_Sua_MonHoc_Ton_Tai]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_KT_Sua_MonHoc_Ton_Tai]
  @MAMH char(5),
  @TENMH nvarchar(40)
AS
	IF  exists(SELECT TENMH FROM  MONHOC WHERE TENMH = @TENMH AND MAMH!= @MAMH)
		raiserror ('Tên môn học đã tồn tại, vui lòng nhập tên khác',16,1)
GO
/****** Object:  StoredProcedure [dbo].[sp_Lay_DS_Khoa]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Lay_DS_Khoa]
    AS
	SELECT MAKH, TENKH, MACS FROM LINK0.TN_CSDLPT.dbo.KHOA
GO
/****** Object:  StoredProcedure [dbo].[SP_Lay_MaCS_Tu_TenCS]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Lay_MaCS_Tu_TenCS]
	@TenCS nvarchar(50)
AS
BEGIN
	Select MACS From dbo.COSO Where TENCS = @TenCS
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Lay_Thong_Tin_GV_Tu_Login]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Lay_Thong_Tin_GV_Tu_Login]
@TENLOGIN NVARCHAR( 100)
AS
DECLARE @UID INT
DECLARE @MAGV NVARCHAR(8)

SELECT @UID = uid , @MAGV = NAME FROM sys.sysusers 
  WHERE sid = SUSER_SID(@TENLOGIN)
SELECT MAGV= @MAGV, 
       HOTEN = (SELECT HO+ ' '+TEN FROM dbo.GIAOVIEN WHERE MAGV=@MAGV), 
       TENNHOM=NAME
  FROM sys.sysusers
    WHERE UID = (SELECT groupuid FROM sys.sysmembers WHERE memberuid= @UID)
GO
/****** Object:  StoredProcedure [dbo].[SP_Lay_Thong_Tin_SV_Tu_Login]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Lay_Thong_Tin_SV_Tu_Login] @maSV nchar(8)

AS
	
		BEGIN
		 SELECT 
		   MASV = @maSV,
		   HOTEN = (SELECT HO+ ' '+ TEN FROM SINHVIEN  WHERE MASV = @maSV),
		   TENNHOM= NAME
		   FROM sys.sysusers 
		   WHERE UID = (SELECT GROUPUID 
						 FROM SYS.SYSMEMBERS 
						   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
											  WHERE NAME='sv'))
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_Bo_De]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_Bo_De]
   @MACH int,
   @MAMH nchar(5),
   @MAGV nchar(8),
   @TRINHDO nchar(1),
   @DAPAN nchar(1),
   @NOIDUNG ntext,
   @A ntext,
   @B ntext,
   @C ntext,
   @D ntext
AS
	
		BEGIN
			UPDATE dbo.BODE SET MAMH = @MAMH, MAGV = @MAGV, TRINHDO = @TRINHDO,
				DAP_AN = @DAPAN, NOIDUNG = @NOIDUNG, A = @A, B = @B, C = @C, D = @D
			WHERE CAUHOI = @MACH
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_GV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_GV]
  @MAGV nchar(8),
  @HOGV nvarchar(50),
  @TENGV nvarchar(10),
  @DIACHI nvarchar(50),
  @MAKHOA nchar(8)

AS
	
		BEGIN
			UPDATE dbo.GIAOVIEN SET HO = @HOGV, TEN = @TENGV, DIACHI = @DIACHI WHERE MAGV = @MAGV
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_GVDK]
  @MAGV nchar(8),
  @MALOP nchar(15),
  @MAMH nchar(5),
  @TRINHDO nchar(1),
  @LAN smallint,
  @NGAYTHI datetime,
  @SOCAU smallint,
  @THOIGIAN smallint
AS
	
		BEGIN
			UPDATE dbo.GIAOVIEN_DANGKY SET 
			MAGV = @MAGV, TRINHDO = @TRINHDO, NGAYTHI = @NGAYTHI, SOCAUTHI = @SOCAU, THOIGIAN = @THOIGIAN 
			WHERE MALOP = @MALOP AND MAMH = @MAMH AND LAN = @LAN
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_Khoa]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_Khoa]
  @MAKHOA nchar(8),
  @TENKHOA nvarchar(50),
  @MACS nchar(3)
AS
	-- Trùng tên khoa
	 IF EXISTS(SELECT TENKH FROM KHOA WHERE TENKH = @TENKHOA AND MAKH != @MAKHOA)
		SELECT '1'
	 ELSE IF EXISTS(SELECT TENKH FROM  LINK0.TN_CSDLPT.dbo.KHOA WHERE TENKH = @TENKHOA AND MAKH != @MAKHOA)
		BEGIN
			SELECT '1'
		END
	--  Sửa khoa
	ELSE 
		BEGIN
			UPDATE dbo.KHOA SET TENKH = @TENKHOA where MAKH=@MAKHOA
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_Lop]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_Lop]
  @MALOP nchar(15),
  @TENLOP nvarchar(40),
  @MAKH nchar(8)
AS
	-- Trùng tên lớp
	 IF  exists(SELECT TENLOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE TENLOP = @TENLOP AND MALOP != @MALOP)
		BEGIN
			SELECT '1'
		END
	--  Sửa lớp
	ELSE 
		BEGIN
			UPDATE dbo.LOP SET TENLOP = @TENLOP where MALOP = @MALOP
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_MH]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_MH]
  @MAMH char(5),
  @TENMH nvarchar(40)
AS
	-- Trùng tên môn học
	 IF  exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TENMH AND MAMH != @MAMH)
		BEGIN
			SELECT '1'
		END
	--  Sửa môn học
	ELSE 
		BEGIN
			UPDATE dbo.MONHOC SET TENMH = @TENMH where MAMH=@MAMH
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Sua_SV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Sua_SV]
  @MASV nchar(8),
  @HOSV nvarchar(50),
  @TENSV nvarchar(10),
  @DIACHI nvarchar(100),
  @NGAYSINH date,
  @MALOP nchar(15),
  @PASSWORD nchar(60)

AS
		BEGIN
			UPDATE dbo.SINHVIEN SET HO = @HOSV, TEN = @TENSV, DIACHI = @DIACHI, NGAYSINH = @NGAYSINH, PASSWORD = @PASSWORD 
			WHERE MASV = @MASV
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_Bo_De]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_Bo_De]
   @MACH int,
   @MAMH nchar(5),
   @MAGV nchar(8),
   @TRINHDO nchar(1),
   @DAPAN nchar(1),
   @NOIDUNG ntext,
   @A ntext,
   @B ntext,
   @C ntext,
   @D ntext

AS
	

	If  exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @MACH)
		BEGIN
			SELECT '1' 
		END
	ELSE 
		BEGIN
			
			INSERT dbo.BODE 
					( CAUHOI, MAMH, MAGV, TRINHDO, DAP_AN, NOIDUNG, A, B, C, D)
			VALUES  (  @MACH,
					   @MAMH,
					   @MAGV ,
					   @TRINHDO,
					   @DAPAN,
					   @NOIDUNG,
					   @A,
					   @B,
					   @C,
					   @D
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_GV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_GV]
  @MAGV nchar(8),
  @HOGV nvarchar(50),
  @TENGV nvarchar(10),
  @DIACHI nvarchar(50),
  @MAKHOA nchar(8)

AS
	

	If  exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV = @MAGV)
		BEGIN
			SELECT '1' --Ton tai ma gv
		END
	ELSE 
		BEGIN
			
			INSERT dbo.GIAOVIEN 
					( MAGV, HO, TEN, DIACHI, MAKH )
			VALUES  ( @MAGV,
					  @HOGV,
					  @TENGV,
					  @DIACHI,
					  @MAKHOA
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_GVDK]
  @MAGV nchar(8),
  @MALOP nchar(15),
  @MAMH nchar(5),
  @TRINHDO nchar(1),
  @LAN smallint,
  @NGAYTHI datetime,
  @SOCAU smallint,
  @THOIGIAN smallint

AS
	

	IF exists(select * from dbo.GIAOVIEN_DANGKY where MAMH = @MAMH AND MALOP = @MALOP AND LAN = @LAN)
		BEGIN
			SELECT '1' --Ton tai 
		END
	ELSE 
		BEGIN
			
			INSERT dbo.GIAOVIEN_DANGKY 
					( MAGV, MALOP, MAMH, TRINHDO, LAN, NGAYTHI, SOCAUTHI, THOIGIAN )
			VALUES  ( @MAGV,
					  @MALOP,
					  @MAMH,
					  @TRINHDO,
					  @LAN,
					  @NGAYTHI,
					  @SOCAU,
					  @THOIGIAN
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_Khoa]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_Khoa]
  @MAKHOA nchar(8),
  @TENKHOA nvarchar(50),
  @MACS nchar(3)
AS
	IF EXISTS(SELECT MAKH FROM KHOA WHERE MAKH =@MAKHOA)
		SELECT '1'
	ELSE IF EXISTS(SELECT TENKH FROM KHOA WHERE TENKH =@TENKHOA)
		SELECT '2'
	ELSE IF EXISTS(SELECT MAKH FROM LINK0.TN_CSDLPT.dbo.KHOA WHERE MAKH = @MAKHOA)
		SELECT '1'
	ELSE IF EXISTS(SELECT TENKH FROM LINK0.TN_CSDLPT.dbo.KHOA WHERE TENKH = @TENKHOA)
		SELECT '2'
	ELSE 
		BEGIN
			INSERT dbo.KHOA 
					( MAKH, TENKH, MACS )
			VALUES  ( @MAKHOA, -- MAKH - nchar(8)
					  @TENKHOA, -- TENKH - nvarchar(50)
					  @MACS -- MaCS nchar(3)
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_Lop]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_Lop]
  @MALOP nchar(15),
  @TENLOP nvarchar(40),
  @MAKH nchar(8)
AS
	If  exists(SELECT MALOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE MALOP = @MALOP)
		SELECT '1'

	IF  exists(SELECT TENLOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE TENLOP = @TENLOP)
		SELECT '2'
	ELSE 
		BEGIN
			INSERT dbo.LOP 
					( MALOP, TENLOP, MAKH )
			VALUES  ( @MALOP, -- MALOP - nchar(15)
					  @TENLOP, -- TENLOP - nvarchar(40)
					  @MAKH -- MAKH nchar(8)
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_MH]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_MH]
  @MAMH nchar(5),
  @TENMH nvarchar(40)
AS
	If  exists(SELECT MAMH FROM  MONHOC WHERE MAMH = @MAMH)
		SELECT '1'

	 IF  exists(SELECT TENMH FROM  MONHOC WHERE TENMH = @TENMH)
		SELECT '2'
	ELSE 
		BEGIN
			INSERT dbo.MONHOC 
					( MAMH, TENMH )
			VALUES  ( @MAMH, -- MAMH - nchar(5)
					  @TENMH -- TENMH - nvarchar(40)
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Them_SV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Them_SV]
  @MASV nchar(8),
  @HOSV nvarchar(50),
  @TENSV nvarchar(10),
  @DIACHI nvarchar(100),
  @NGAYSINH date,
  @MALOP nchar(15),
  @PASSWORD nchar(60)

AS

	If  exists(SELECT MASV FROM  LINK1.TN_CSDLPT.dbo.SINHVIEN WHERE MASV = @MASV)
		BEGIN
			SELECT '1' --Ton tai ma sv
		END
	ELSE 
		BEGIN
			
			INSERT dbo.SINHVIEN 
					( MASV, HO, TEN,NGAYSINH, DIACHI, MALOP, PASSWORD)
			VALUES  ( @MASV,
					  @HOSV,
					  @TENSV,
					  @NGAYSINH,
					  @DIACHI,
					  @MALOP,
					  @PASSWORD
					)
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_Bo_De]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_Bo_De]
   @MACH int,
   @MAMH nchar(5),
   @MAGV nchar(8),
   @TRINHDO nchar(1),
   @DAPAN nchar(1),
   @NOIDUNG ntext,
   @A ntext,
   @B ntext,
   @C ntext,
   @D ntext

AS
	--Chi tiết bài thi
	 IF  exists(SELECT * FROM dbo.CT_BAITHI WHERE MACH = @MACH)
		BEGIN
			SELECT '1'
		END
	-- Xóa 
	ELSE 
		BEGIN
			DELETE dbo.BODE where CAUHOI = @MACH
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_GV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_GV]
  @MAGV nchar(8),
  @HOGV nvarchar(50),
  @TENGV nvarchar(10),
  @DIACHI nvarchar(50),
  @MAKHOA nchar(8)

AS
	--Bộ đề
	 IF  exists(SELECT * FROM dbo.BODE WHERE MAGV = @MAGV)
		BEGIN
			SELECT '1'
		END
	-- Giáo viên đăng ký
	ELSE IF  exists(SELECT * FROM dbo.GIAOVIEN_DANGKY WHERE MAGV = @MAGV)
		BEGIN
			SELECT '2'
		END

	-- Xóa giáo viên
	ELSE 
		BEGIN
			DELETE dbo.GIAOVIEN where MAGV = @MAGV
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_GVDK]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_GVDK]
 @MAGV nchar(8),
  @MALOP nchar(15),
  @MAMH nchar(5),
  @TRINHDO nchar(1),
  @LAN smallint,
  @NGAYTHI datetime,
  @SOCAU smallint,
  @THOIGIAN smallint

AS
	DECLARE @KQ nchar(1)
	SET @KQ = dbo.Check_Lop_MH_Da_Thi(@MAMH, @MAlOP, @LAN)

	IF @KQ = 'X' 
	   SELECT '1'
	ELSE 
		BEGIN
			DELETE dbo.GIAOVIEN_DANGKY where MALOP = @MALOP AND MAMH = @MAMH AND LAN = @LAN
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_Khoa]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_Khoa]
   @MAKHOA nchar(8),
  @TENKHOA nvarchar(50),
  @MACS nchar(3)
AS
	-- Lop
	 IF  exists(SELECT * FROM dbo.LOP WHERE MAKH = @MAKHOA)
		BEGIN
			SELECT '1'
		END
	-- Giao vien
	ELSE IF  exists(SELECT * FROM dbo.GIAOVIEN WHERE MAKH = @MAKHOA)
		BEGIN
			SELECT '2'
		END

	-- Xóa khoa
	ELSE 
		BEGIN
			DELETE dbo.KHOA where MAKH = @MAKHOA
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_Lop]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_Lop]
  @MALOP nchar(15),
  @TENLOP nvarchar(40),
  @MAKH nchar(8)
AS
	-- Sinh vien
	 IF  exists(SELECT MALOP FROM dbo.SINHVIEN WHERE MALOP = @MALOP)
		BEGIN
			SELECT '1'
		END
	-- Giao vien dang ky
	ELSE IF  exists(SELECT MALOP FROM dbo.GIAOVIEN_DANGKY WHERE MALOP = @MALOP)
		BEGIN
			SELECT '2'
		END

	-- Xóa lớp
	ELSE 
		BEGIN
			DELETE dbo.LOP where MALOP = @MALOP
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_MH]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_MH]
  @MAMH char(5),
  @TENMH nvarchar(40)
AS
	--Bảng điểm
	 IF  exists(SELECT * FROM BANGDIEM WHERE MAMH = @MAMH)
		BEGIN
			SELECT '1'
		END
	-- Bộ đề
	ELSE IF  exists(SELECT * FROM BODE WHERE MAMH = @MAMH)
		BEGIN
			SELECT '2'
		END

	--Giảng viên đăng ký
	ELSE IF  exists(SELECT * FROM GIAOVIEN_DANGKY WHERE MAMH = @MAMH)
		BEGIN
			SELECT '3'
		END

	-- Xóa môn học
	ELSE 
		BEGIN
			DELETE dbo.MONHOC where MAMH=@MAMH
			SELECT '0';
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Phuc_Hoi_Xoa_SV]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_Phuc_Hoi_Xoa_SV]
  @MASV nchar(8),
  @HOSV nvarchar(50),
  @TENSV nvarchar(10),
  @DIACHI nvarchar(100),
  @NGAYSINH date,
  @MALOP nchar(15),
  @PASSWORD nchar(60)

AS
	--Bảng điểm
	 IF  exists(SELECT MASV FROM dbo.BANGDIEM WHERE MASV = @MASV)
		BEGIN
			SELECT '1'
		END
	
	-- Xóa sinh viên
	ELSE 
		BEGIN
			DELETE dbo.SINHVIEN where MASV = @MASV
			SELECT '0'
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_TAOLOGIN]    Script Date: 4/24/2022 10:06:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TAOLOGIN]
  @LGNAME VARCHAR(50),
  @PASS VARCHAR(50),
  @USERNAME VARCHAR(50),
  @ROLE VARCHAR(50)
AS
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS,'TN_CSDLPT'
  IF (@RET =1)  -- LOGIN NAME BI TRUNG
     RETURN 1
 
  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME
  IF (@RET =1)  -- USER  NAME BI TRUNG
  BEGIN
       EXEC SP_DROPLOGIN @LGNAME
       RETURN 2
  END
  EXEC sp_addrolemember @ROLE, @USERNAME
  IF @ROLE= 'TRUONG' OR @ROLE= 'COSO'
  BEGIN 
    EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
    EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
  END
   ELSE IF @ROLE= 'GIANGVIEN'
	BEGIN  
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END

	RETURN 0  -- THANH CONG
RETURN 0  -- THANH CONG
GO
