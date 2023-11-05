enum ErrorTypeConstants {
    enum ConnectionError {
        static let icon = ProductFinderImages.Icons.errorConnectionImage
        static let title = "¡Parece que no hay internet!"
        static let message = "Revisa tu conexión para seguir navegando."
    }

    enum NoResultError {
        static let icon = ProductFinderImages.Icons.errorSearchImage
        static let title = "No encontramos el producto"
        static let message = """
        Revisa que la palabra esté bien escrita.
        También puedes probar con menos términos o más generales.
        """
    }

    enum GenericError {
        static let icon = ProductFinderImages.Icons.errorDefaultImage
        static let title = "Lo sentimos, ha ocurrido un problema"
        static let message = "Por favor intenta nuevamente"
    }
}
