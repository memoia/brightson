namespace Memoia.Brightson.Tests {

  using Memoia.Brightson;
  using NUnit.Framework;

  [TestFixture]
  public class FooTest {

    [Test]
    public void TestFoo() {
      Assert.AreEqual(Foo.Blah(), 1);
    }
  }

}
