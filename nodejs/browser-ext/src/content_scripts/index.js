import _ from "lodash";

(async () => {
  // Showcase that dependencies can be bundled
  const arr = [1, 2, 3, 4, 5];
  const chunks = _.chunk(arr, 2);
  console.log(chunks); // [[1,2],[3,4],[5]]
})();
