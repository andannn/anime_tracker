String get userContentQueryGraphql => '''
          id
          name
          avatar {
            large
          }
          bannerImage
          options {
            profileColor
          }
''';

String get userContentWithSettingsQueryGraphql => '''
          id
          name
          avatar {
            large
            medium
          }
          bannerImage
          options {
            titleLanguage
            displayAdultContent
            airingNotifications
            profileColor
            timezone
            activityMergeTime
            staffNameLanguage
            restrictMessagesToFollowing
          }
''';