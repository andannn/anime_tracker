String get characterPageGraphql =>
'''
query (\$id: Int, \$page: Int, \$perPage: Int, \$staffLanguage: StaffLanguage) {
  Media(id: \$id) {
    characters(page: \$page, perPage: \$perPage, sort: RELEVANCE) {
      pageInfo {
        total
        perPage
        currentPage
        lastPage
        hasNextPage
      }
      edges {
        role
        node {
          id
          image {
            large
            medium
          }
          name {
            full
            native
          }
        }
        voiceActors(language: \$staffLanguage, sort: LANGUAGE) {
          id
          image {
            large
            medium
          }
          name {
            full
            native
          }
        }
      }
    }
  }
}
''';