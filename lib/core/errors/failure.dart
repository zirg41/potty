// ignore_for_file: constant_identifier_names

abstract class Failure {}

class CacheFailure extends Failure {}

const GETTING_DATA_FROM_MEMORY_FAILED =
    'Ошибка чтения данных с памяти устройства. Пожалуйста перезагрузите приложение';
const NO_STATE_ERROR = 'No State';
const CACHE_FAILURE_MESSAGE = 'Ошибка чтения с памяти телефона';
const INVALID_INPUT_FAILURE_MESSAGE =
    'Значение должно быть положительным числом и не содержать символы';
