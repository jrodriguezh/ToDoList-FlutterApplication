class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C in CRUD
class CouldNoteCreateNoteException extends CloudStorageException {}

// R in CRUD
class CouldNoteGetAllNotesException extends CloudStorageException {}

// U in CRUD
class CouldNotUpdateNoteException extends CloudStorageException {}

// D in CRUD
class CouldNotDeleteNoteException extends CloudStorageException {}

// C in CRUD
class CouldNoteCreateEventException extends CloudStorageException {}

// R in CRUD
class CouldNoteGetAllEventException extends CloudStorageException {}

// U in CRUD
class CouldNotUpdateEventException extends CloudStorageException {}

// D in CRUD
class CouldNotDeleteEventException extends CloudStorageException {}
