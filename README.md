# workExperience
## Setup
1. Clone the repository
2. Create a file within the main repository folder called `config.js`
3. Copy-paste the following code into `config.js`:
```
// Initialize Firebase
var config = {
  apiKey: "<apiKey from firebase>",
  authDomain: "final-project-40d8a.firebaseapp.com",
  databaseURL: "https://final-project-40d8a.firebaseio.com",
  projectId: "final-project-40d8a",
  storageBucket: "final-project-40d8a.appspot.com",
  messagingSenderId: "<Sender ID indicated in Firebase Settings > Cloud Messaging>"
};
```
4. Do **NOT** commit `config.js` to the repository. `apiKey` and `messagingSenderId` are sensitive information that do not belong in the repository.

## Contact
Created by [@lrbloch](https://github.com/lrbloch)