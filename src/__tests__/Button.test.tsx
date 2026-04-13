import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Button } from "../components/Button/Button.bs.js";

describe("Button", () => {
	it("renders with children text", () => {
		render(<Button.make>Click me</Button.make>);
		expect(screen.getByText("Click me")).toBeInTheDocument();
	});

	it("renders as a button element", () => {
		render(<Button.make>Test</Button.make>);
		expect(screen.getByRole("button")).toBeInTheDocument();
	});

	it("calls onClick when clicked", () => {
		const handleClick = vi.fn();
		render(<Button.make onClick={handleClick}>Click</Button.make>);
		fireEvent.click(screen.getByRole("button"));
		expect(handleClick).toHaveBeenCalledOnce();
	});

	it("is disabled when disabled prop is true", () => {
		render(<Button.make disabled={true}>Disabled</Button.make>);
		expect(screen.getByRole("button")).toBeDisabled();
	});

	it("is disabled when loading", () => {
		render(<Button.make loading={true}>Loading</Button.make>);
		expect(screen.getByRole("button")).toBeDisabled();
	});

	it("renders with type=submit", () => {
		render(<Button.make type_="submit">Submit</Button.make>);
		expect(screen.getByRole("button")).toHaveAttribute("type", "submit");
	});

	it("applies aria-label", () => {
		render(<Button.make ariaLabel="Close dialog">X</Button.make>);
		expect(screen.getByLabelText("Close dialog")).toBeInTheDocument();
	});
});
