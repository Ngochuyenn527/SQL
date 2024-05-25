USE master
IF(EXISTS(SELECT * FROM SYSDATABASES WHERE NAME ='QLKHO'))
DROP DATABASE QLKHO
GO
CREATE DATABASE QLKHO
GO
USE QLKHO
CREATE TABLE TON(
 MAVT INT PRIMARY KEY NOT NULL,
 TENVT CHAR(20) NOT NULL,
 SOLUONGT INT NOT NULL
)
CREATE TABLE NHAP (
 SOHDN CHAR(20)  NOT NULL,
 MAVT INT NOT NULL ,
 SOLUONGN INT NOT NULL,
 DONGIAN MONEY NOT NULL,
 NGAYN DATE NOT NULL,
 CONSTRAINT PK PRIMARY KEY(SOHDN, MAVT),
 CONSTRAINT FK FOREIGN KEY(MAVT) REFERENCES TON(MAVT) ON UPDATE CASCADE ON DELETE CASCADE
 )

CREATE TABLE XUAT (
 SOHDX CHAR(20) NOT NULL,
 MAVT INT NOT NULL,
 SOLUONGX INT NOT NULL,
 DONGIAX MONEY NOT NULL,
 NGAYX DATE NOT NULL,
 CONSTRAINT PK1 PRIMARY KEY(SOHDX, MAVT),
 CONSTRAINT FK1 FOREIGN KEY(MAVT) REFERENCES TON(MAVT) ON UPDATE CASCADE ON DELETE CASCADE
 )

INSERT INTO TON VALUES
(1, N'F1 PLUS',  100),
(2, N'F2 PLUS',  200),
(3, N'F3 PLUS',  300),
(4, N'F4 PLUS',  400),
(5, N'F5 PLUS',  500)

INSERT INTO NHAP VALUES
(N'N01', 1, 5, 1000000, '2019-2-5'),
(N'N02', 2, 4, 12000000, '2010-2-5'),
(N'N03', 3, 3, 33000000, '2011-2-5')

INSERT INTO XUAT VALUES
(N'X01', 1, 4, 30000, '2019-2-5'),
(N'X02', 2, 12, 2000000, '2010-2-5')

SELECT * FROM TON
SELECT * FROM NHAP
SELECT * FROM XUAT
SELECT TON.MAVT,TENVT, SUM(SOLUONGX*DONGIAX) AS TIENBAN
FROM TON INNER JOIN XUAT ON TON.MAVT=XUAT.MAVT
GROUP BY TON.MAVT, TENVT

SELECT TON.TENVT, SOLUONGX
FROM TON INNER JOIN XUAT ON TON.MAVT=XUAT.MAVT
GROUP BY TENVT, SOLUONGX

SELECT TON.TENVT, SOLUONGN
FROM TON INNER JOIN NHAP ON TON.MAVT=NHAP.MAVT
GROUP BY TENVT, SOLUONGN

SELECT TON.MAVT, SUM(SOLUONGN - SOLUONGX + SOLUONGT) AS DU
FROM TON INNER JOIN NHAP  ON TON.MAVT=NHAP.MAVT   
INNER JOIN XUAT ON TON.MAVT=XUAT.MAVT
GROUP BY TON.MAVT

SELECT TON.MAVT, TON.TENVT, TON.SOLUONGT AS TONMAX FROM TON
WHERE SOLUONGT = (SELECT MAX(SOLUONGT) FROM TON)

SELECT * FROM XUAT
SELECT TON.MAVT, TON.TENVT
FROM TON INNER JOIN XUAT ON TON.MAVT=XUAT.MAVT
GROUP BY TON.MAVT, TON.TENVT
HAVING SUM(SOLUONGX) > 100


SELECT MONTH(NGAYX) AS MONTH, YEAR(NGAYX) AS YEAR, SUM(SOLUONGX) AS TONGSL FROM XUAT
GROUP BY MONTH(NGAYX), YEAR(NGAYX)


INSERT INTO XUAT VALUES (N'X03', 3, 12, 2000000, '2015-2-5')
SELECT * FROM XUAT
INSERT INTO NHAP VALUES (N'X03', 4, 12, 2000000, '2015-3-5')
SELECT * FROM NHAP
SELECT TON.MAVT, TON.TENVT, SUM( SoluongN-SoLuongX+SoLuongT) AS DU FROM TON
INNER JOIN XUAT ON XUAT.MAVT = TON.MAVT
INNER JOIN NHAP ON NHAP.MAVT = TON.MAVT
WHERE YEAR(NGAYX) =2015 AND YEAR(NGAYN) = 2015
GROUP BY TON.MAVT, TON.TENVT

SELECT * FROM XUAT
SELECT * FROM TON
SELECT TON.MAVT, TON.TENVT FROM TON
WHERE ton.mavt not in (select mavt FROM XUAT)


















