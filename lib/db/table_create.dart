// 患者表
const patientsTableCreateSql = '''
CREATE TABLE Patients (
    PatientID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Gender TEXT CHECK (Gender IN ('Male', 'Female', 'Other')),
    DateOfBirth DATE,
    ContactInfo TEXT
);
''';

// 药品库存表
const medicationStockTableCreateSql = '''
CREATE TABLE MedicationStock (
    MedicationName TEXT PRIMARY KEY,
    StockQuantity INTEGER NOT NULL CHECK (StockQuantity >= 0),
    Unit TEXT NOT NULL, -- 如“片”、“瓶”等
    AveragePrice REAL NOT NULL CHECK (AveragePrice >= 0) -- 药品均价
);
''';

const medicationInventoryRecordsTableCreateSql = '''
CREATE TABLE MedicationInventoryRecords (
    RecordID INTEGER PRIMARY KEY AUTOINCREMENT,
    MedicationName TEXT NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0), -- 入库数量
    UnitPrice REAL NOT NULL CHECK (UnitPrice > 0), -- 入库单价
    TotalPrice AS (Quantity * UnitPrice), -- 计算字段，记录总金额
    EntryDate DATE NOT NULL DEFAULT CURRENT_DATE, -- 入库日期
    FOREIGN KEY (MedicationName) REFERENCES MedicationStock(MedicationName)
);
''';

const prescriptionsTableCreateSql = '''
CREATE TABLE Prescriptions (
    PrescriptionID INTEGER PRIMARY KEY AUTOINCREMENT,
    PatientID INTEGER NOT NULL,
    PrescriptionDate DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
''';

const prescriptionDetailsTableCreateSql = '''
CREATE TABLE PrescriptionDetails (
    DetailID INTEGER PRIMARY KEY AUTOINCREMENT,
    PrescriptionID INTEGER NOT NULL,
    MedicationName TEXT NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    Dosage TEXT,
    Instructions TEXT,
    FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
    FOREIGN KEY (MedicationName) REFERENCES MedicationStock(MedicationName)
);
''';
