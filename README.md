# recipewizard

### Summary: Include screen shots or a video of your app highlighting its features

| Home Screen | Cuisine Filter | Recipes Failure | Image Failure |
| ----------- | -------------- | --------------- | ------------- |
| ![alt text][RecipeWizard] | ![alt text][CuisineFilter] | ![alt text][RecipesFailure] | ![alt text][ImageFailure] |

[RecipeWizard]: https://github.com/colbrew/recipewizard/raw/main/RecipeWizard.jpg "Recipe Wizard"
[CuisineFilter]: https://github.com/colbrew/recipewizard/raw/main/CuisineFilter.jpg "Cuisine Filter"
[RecipesFailure]: https://github.com/colbrew/recipewizard/raw/main/FetchRecipesFailure.jpg "Fetch Recipes Failure"
[ImageFailure]: https://github.com/colbrew/recipewizard/raw/main/ImageFailure.jpg "Load Image Failure"

[RecipeWizard Demo Video](https://drive.google.com/file/d/1NYE7dJtuLUfl9zc54fwbfPL6OEmHHnzc/view?usp=share_link)

[RecipeWizard Recover From Failure Video](https://drive.google.com/file/d/1lsWyOsnn9ljzwXHXhylp55z8DN6K9iaw/view?usp=share_link)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

1. Basic UI and Functionality
2. Disk Caching
3. Tests
    
These seemed to be the core parts of the challenge, and gave me an opportunity to demonstrate my skills in different areas. I also wanted to spend some time trying out the `@Observable` macro (I've been doing a lot of platform work lately), trying out Swift Testing, turning on Swift 6 strict concurrency and learning about different approaches to caching and implementing my own version.
     
### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

| **9 hours** | |
| --- | --- |
| 30 minutes | Planning and Setup |
| 2 hours | App Functionality and UI |
| 30 minute | Recipe Filtering Feature |
| 2 hours | Disk Caching |
| 2 hours | Writing Protocols, Refactoring and Writing Tests |
| 2 hours | Swift 6 Strict Concurrency |

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I decided to not focus on polishing the UI of the app. I got the UI to a decent state but did not spend time honing the appearance. I felt it was more important to get it working well, with the required disk cache and tests.

### Weakest Part of the Project: What do you think is the weakest part of your project?

See above. The UI - it is very basic. Would need improvement, refinement and polishing. 

The caching also needs to be refined - I would add some mix of max cache size, expiration, cache ejection rules (probably Least Recently Used). I would also complement the disk cache with an NSCache in-memory cache to really sharpen the performance.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

The disk caching felt very exercis-y. I appreciate that is a nice way to show a lot of different skills like managing files and writing tests that interact with the system. In a real app for a small or mid-size company, I would likely use a third-party library.

In a production app, I would write UI tests (at the very least), spend additional time on accessibility, localization (if needed), performance testing and app optimization. I would also add logging to be able to track app perfomance and user behavior. I would also likely add navigation.

> Note: You can set the `resetCacheAtStart` environment variable to `true` in the RecipeWizard scheme if you want all caches to be purged at the start of each run.
