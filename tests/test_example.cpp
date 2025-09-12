#include <gtest/gtest.h>

// Example test
TEST(ExampleTest, BasicAssertion) {
    EXPECT_EQ(2 + 2, 4);
    EXPECT_TRUE(true);
}

TEST(ExampleTest, AnotherTest) {
    EXPECT_STREQ("hello", "hello");
}